import hashlib
import re
import secrets
import smtplib
from dataclasses import dataclass
from datetime import datetime, timedelta, timezone
from email.message import EmailMessage

from psycopg.rows import dict_row
from werkzeug.security import check_password_hash, generate_password_hash

from backend.config import Settings, settings
from backend.database import get_connection


MATRICULA_PATTERN = re.compile(r"^[0-9]{1,20}$")
ACTIVATION_CODE_LENGTH = 6
ACTIVATION_MINUTES = 15
MAX_ACTIVATION_ATTEMPTS = 5


class AuthError(RuntimeError):
    def __init__(self, code: str, message: str, status: int = 400) -> None:
        super().__init__(message)
        self.code = code
        self.message = message
        self.status = status


@dataclass(frozen=True)
class ActivationResult:
    development_code: str | None = None


def normalize_matricula(value: str) -> str:
    matricula = value.strip() if isinstance(value, str) else ""
    if not MATRICULA_PATTERN.fullmatch(matricula):
        raise AuthError("invalid_matricula", "La matrícula no tiene un formato válido.")
    return matricula


def institutional_email(matricula: str, config: Settings = settings) -> str:
    return f"L{matricula}@{config.institutional_email_domain}".lower()


def _token_hash(value: str) -> str:
    return hashlib.sha256(value.encode("utf-8")).hexdigest()


def _send_activation_email(
    email: str, code: str, config: Settings = settings
) -> None:
    if not config.smtp_host or not config.smtp_from:
        raise AuthError(
            "email_unavailable",
            "La activación por correo no está configurada.",
            503,
        )

    message = EmailMessage()
    message["Subject"] = "Código de activación de NEXO"
    message["From"] = config.smtp_from
    message["To"] = email
    message.set_content(
        "Tu código de activación de NEXO es: "
        f"{code}\n\nEl código vence en {ACTIVATION_MINUTES} minutos y solo puede usarse una vez."
    )
    try:
        with smtplib.SMTP(config.smtp_host, config.smtp_port, timeout=10) as server:
            server.starttls()
            if config.smtp_user:
                server.login(config.smtp_user, config.smtp_password)
            server.send_message(message)
    except (OSError, smtplib.SMTPException) as error:
        raise AuthError(
            "email_unavailable",
            "No fue posible enviar el código de activación.",
            503,
        ) from error


def request_activation(
    matricula_value: str, config: Settings = settings
) -> ActivationResult:
    matricula = normalize_matricula(matricula_value)
    email = institutional_email(matricula, config)
    code = f"{secrets.randbelow(10**ACTIVATION_CODE_LENGTH):0{ACTIVATION_CODE_LENGTH}d}"
    now = datetime.now(timezone.utc)

    with get_connection(config) as connection:
        with connection.transaction():
            connection.row_factory = dict_row
            with connection.cursor() as cursor:
                cursor.execute(
                    """
                    SELECT nombre
                    FROM nexo.padron_estudiantes
                    WHERE matricula = %s AND autorizado = TRUE
                    FOR SHARE
                    """,
                    (matricula,),
                )
                student = cursor.fetchone()
                if student is None:
                    return ActivationResult()

                cursor.execute(
                    """
                    SELECT id, estado
                    FROM nexo.usuarios
                    WHERE matricula = %s
                    FOR UPDATE
                    """,
                    (matricula,),
                )
                account = cursor.fetchone()
                if account and account["estado"] != "PENDING":
                    return ActivationResult()

                if account is None:
                    cursor.execute(
                        """
                        INSERT INTO nexo.usuarios
                            (matricula, nombre, correo, contrasena_hash, rol, activo, estado)
                        VALUES (%s, %s, %s, NULL, 'estudiante', TRUE, 'PENDING')
                        RETURNING id
                        """,
                        (matricula, student["nombre"] or matricula, email),
                    )
                    account_id = cursor.fetchone()["id"]
                else:
                    account_id = account["id"]

                cursor.execute(
                    """
                    UPDATE nexo.activaciones
                    SET usado = TRUE
                    WHERE usuario_id = %s AND usado = FALSE
                    """,
                    (account_id,),
                )
                cursor.execute(
                    """
                    INSERT INTO nexo.activaciones
                        (usuario_id, codigo_hash, expira_en)
                    VALUES (%s, %s, %s)
                    """,
                    (
                        account_id,
                        _token_hash(code),
                        now + timedelta(minutes=ACTIVATION_MINUTES),
                    ),
                )

    if config.auth_dev_code_output and config.environment != "production":
        return ActivationResult(development_code=code)
    _send_activation_email(email, code, config)
    return ActivationResult()


def set_password(
    matricula_value: str, code: str, password: str, config: Settings = settings
) -> None:
    if not isinstance(password, str) or len(password) < 10:
        raise AuthError(
            "weak_password",
            "La contraseña debe tener al menos 10 caracteres.",
        )
    matricula = normalize_matricula(matricula_value)
    normalized_code = code.strip() if isinstance(code, str) else ""
    with get_connection(config) as connection:
        with connection.transaction():
            connection.row_factory = dict_row
            with connection.cursor() as cursor:
                cursor.execute(
                    """
                    SELECT a.id, a.codigo_hash, a.expira_en, a.intentos,
                           a.usado, u.id AS usuario_id
                    FROM nexo.activaciones a
                    JOIN nexo.usuarios u ON u.id = a.usuario_id
                    WHERE u.matricula = %s AND u.estado = 'PENDING'
                    ORDER BY a.creado_en DESC
                    LIMIT 1
                    FOR UPDATE
                    """,
                    (matricula,),
                )
                activation = cursor.fetchone()
                if (
                    activation is None
                    or activation["usado"]
                    or activation["expira_en"] <= datetime.now(timezone.utc)
                    or activation["intentos"] >= MAX_ACTIVATION_ATTEMPTS
                    or not secrets.compare_digest(
                        activation["codigo_hash"], _token_hash(normalized_code)
                    )
                ):
                    if activation is not None and not activation["usado"]:
                        cursor.execute(
                            "UPDATE nexo.activaciones SET intentos = intentos + 1 WHERE id = %s",
                            (activation["id"],),
                        )
                    raise AuthError("invalid_code", "El código no es válido.")

                cursor.execute(
                    """
                    UPDATE nexo.usuarios
                    SET contrasena_hash = %s, estado = 'ACTIVE',
                        activo = TRUE, correo_verificado_en = now(),
                        activado_en = now()
                    WHERE matricula = %s AND estado = 'PENDING'
                    """,
                    (generate_password_hash(password), matricula),
                )
                if cursor.rowcount != 1:
                    raise AuthError("activation_unavailable", "La activación no está disponible.")
                cursor.execute(
                    "UPDATE nexo.activaciones SET usado = TRUE, verificado_en = now() WHERE id = %s",
                    (activation["id"],),
                )


def authenticate(
    matricula_value: str, password: str, config: Settings = settings
) -> dict[str, object]:
    matricula = normalize_matricula(matricula_value)
    with get_connection(config) as connection:
        connection.row_factory = dict_row
        with connection.cursor() as cursor:
            cursor.execute(
                """
                SELECT id, matricula, contrasena_hash, estado, rol
                FROM nexo.usuarios
                WHERE matricula = %s
                """,
                (matricula,),
            )
            account = cursor.fetchone()

    if (
        account is None
        or account["estado"] != "ACTIVE"
        or not account["contrasena_hash"]
        or not isinstance(password, str)
        or not check_password_hash(account["contrasena_hash"], password)
    ):
        raise AuthError("invalid_credentials", "Las credenciales no son válidas.", 401)
    return account
