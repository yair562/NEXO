"""Importa un padrón institucional autorizado desde un CSV controlado."""

import argparse
import csv
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from backend.auth import institutional_email, normalize_matricula
from backend.config import settings
from backend.database import get_connection


def import_roster(csv_path: Path) -> tuple[int, list[str]]:
    accepted: list[tuple[str, str | None, str]] = []
    rejected: list[str] = []
    seen: set[str] = set()

    with csv_path.open("r", encoding="utf-8-sig", newline="") as file:
        for line_number, row in enumerate(csv.DictReader(file), start=2):
            try:
                matricula = normalize_matricula(row.get("matricula", ""))
            except Exception:
                rejected.append(f"línea {line_number}: matrícula inválida")
                continue
            if matricula in seen:
                rejected.append(f"línea {line_number}: matrícula duplicada")
                continue
            seen.add(matricula)
            accepted.append(
                (matricula, (row.get("nombre") or "").strip() or None,
                 institutional_email(matricula))
            )

    imported = 0
    with get_connection() as connection:
        with connection.transaction():
            with connection.cursor() as cursor:
                for matricula, nombre, correo in accepted:
                    cursor.execute(
                        "SELECT 1 FROM nexo.padron_estudiantes WHERE matricula = %s",
                        (matricula,),
                    )
                    if cursor.fetchone():
                        rejected.append(f"{matricula}: ya existe en el padrón")
                        continue
                    cursor.execute(
                        """
                        INSERT INTO nexo.padron_estudiantes (matricula, nombre, correo)
                        VALUES (%s, %s, %s)
                        """,
                        (matricula, nombre, correo),
                    )
                    imported += 1
    return imported, rejected


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("csv", type=Path, help="CSV con columnas: matricula,nombre")
    args = parser.parse_args()
    try:
        imported, rejected = import_roster(args.csv)
    except (OSError, KeyError) as error:
        print(f"Error de importación: {error}", file=sys.stderr)
        return 1
    print(f"Importados: {imported}")
    print(f"Rechazados: {len(rejected)}")
    for reason in rejected:
        print(f"- {reason}")
    return 0 if not rejected else 2


if __name__ == "__main__":
    raise SystemExit(main())
