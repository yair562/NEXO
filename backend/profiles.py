from typing import Any

from psycopg.rows import dict_row

from backend.config import Settings, settings
from backend.database import get_connection


# Límites de las columnas de nexo.perfiles (V001__baseline_schema.sql).
CARRERA_MAX = 100
BIOGRAFIA_MAX = 500
ETIQUETAS_MAX_TOTAL = 500
ETIQUETA_MAX = 40
ETIQUETAS_MAX = 15
SEMESTRE_MIN, SEMESTRE_MAX = 1, 12


class ProfileError(ValueError):
    def __init__(self, field: str, message: str) -> None:
        super().__init__(message)
        self.field = field
        self.message = message


def normalize_tags(value: Any, field: str) -> str | None:
    """Convierte "PHP, diseño ,  php" en "PHP, diseño": sin repetidos (sin importar mayúsculas), máximo 15."""
    if value is None:
        return None
    if not isinstance(value, str):
        raise ProfileError(field, "Escribe las etiquetas separadas por comas.")
    tags: dict[str, str] = {}
    for raw in value.split(","):
        tag = " ".join(raw.split())[:ETIQUETA_MAX]
        if tag:
            tags.setdefault(tag.lower(), tag)
    joined = ", ".join(list(tags.values())[:ETIQUETAS_MAX])
    if len(joined) > ETIQUETAS_MAX_TOTAL:
        raise ProfileError(field, f"Máximo {ETIQUETAS_MAX_TOTAL} caracteres en total.")
    return joined or None


def _optional_text(value: Any, field: str, limit: int) -> str | None:
    if value is None:
        return None
    if not isinstance(value, str):
        raise ProfileError(field, "El valor no es válido.")
    text = value.strip()
    if len(text) > limit:
        raise ProfileError(field, f"Máximo {limit} caracteres.")
    return text or None


def _semestre(value: Any) -> int | None:
    if value is None or (isinstance(value, str) and not value.strip()):
        return None
    try:
        semestre = int(value)
    except (TypeError, ValueError):
        raise ProfileError("semestre", "El semestre debe ser un número.") from None
    if isinstance(value, bool) or not SEMESTRE_MIN <= semestre <= SEMESTRE_MAX:
        raise ProfileError("semestre", f"El semestre debe estar entre {SEMESTRE_MIN} y {SEMESTRE_MAX}.")
    return semestre


def _materia_ids(value: Any) -> list[int]:
    if value is None:
        return []
    if not isinstance(value, list) or not all(isinstance(item, int) and not isinstance(item, bool) for item in value):
        raise ProfileError("materias", "La lista de materias no es válida.")
    return sorted(set(value))


def list_subjects(config: Settings = settings) -> list[dict[str, Any]]:
    with get_connection(config) as connection:
        connection.row_factory = dict_row
        with connection.cursor() as cursor:
            cursor.execute("SELECT id, nombre, carrera, semestre FROM nexo.materias ORDER BY semestre, nombre")
            return cursor.fetchall()


def get_profile(user_id: int, config: Settings = settings) -> dict[str, Any]:
    """Perfil de la cuenta; si todavía no lo ha llenado, devuelve los campos vacíos."""
    with get_connection(config) as connection:
        connection.row_factory = dict_row
        with connection.cursor() as cursor:
            cursor.execute(
                """
                SELECT carrera, semestre, biografia, habilidades, intereses, actualizado_en
                FROM nexo.perfiles
                WHERE usuario_id = %s
                """,
                (user_id,),
            )
            profile = cursor.fetchone() or {
                "carrera": None, "semestre": None, "biografia": None,
                "habilidades": None, "intereses": None, "actualizado_en": None,
            }
            cursor.execute(
                "SELECT materia_id FROM nexo.usuario_materias WHERE usuario_id = %s ORDER BY materia_id",
                (user_id,),
            )
            profile["materias"] = [row["materia_id"] for row in cursor.fetchall()]
    return profile


def save_profile(user_id: int, payload: dict[str, Any], config: Settings = settings) -> dict[str, Any]:
    """Valida y guarda el perfil y las materias en una sola transacción."""
    carrera = _optional_text(payload.get("carrera"), "carrera", CARRERA_MAX)
    semestre = _semestre(payload.get("semestre"))
    biografia = _optional_text(payload.get("biografia"), "biografia", BIOGRAFIA_MAX)
    habilidades = normalize_tags(payload.get("habilidades"), "habilidades")
    intereses = normalize_tags(payload.get("intereses"), "intereses")
    materias = _materia_ids(payload.get("materias"))

    with get_connection(config) as connection:
        with connection.transaction():
            with connection.cursor() as cursor:
                if materias:
                    cursor.execute("SELECT count(*) FROM nexo.materias WHERE id = ANY(%s)", (materias,))
                    if cursor.fetchone()[0] != len(materias):
                        raise ProfileError("materias", "Alguna materia seleccionada no existe.")
                cursor.execute(
                    """
                    INSERT INTO nexo.perfiles (usuario_id, carrera, semestre, biografia, habilidades, intereses)
                    VALUES (%s, %s, %s, %s, %s, %s)
                    ON CONFLICT (usuario_id) DO UPDATE
                    SET carrera = EXCLUDED.carrera, semestre = EXCLUDED.semestre,
                        biografia = EXCLUDED.biografia, habilidades = EXCLUDED.habilidades,
                        intereses = EXCLUDED.intereses
                    """,
                    (user_id, carrera, semestre, biografia, habilidades, intereses),
                )
                cursor.execute("DELETE FROM nexo.usuario_materias WHERE usuario_id = %s", (user_id,))
                for materia_id in materias:
                    cursor.execute(
                        "INSERT INTO nexo.usuario_materias (usuario_id, materia_id) VALUES (%s, %s)",
                        (user_id, materia_id),
                    )
    return get_profile(user_id, config)
