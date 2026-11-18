import os
import secrets
from dataclasses import dataclass
from pathlib import Path

from dotenv import load_dotenv


PROJECT_ROOT = Path(__file__).resolve().parents[1]
load_dotenv(PROJECT_ROOT / ".env", override=False)


def _read_bool(name: str, default: bool) -> bool:
    value = os.getenv(name)
    if value is None:
        return default

    normalized = value.strip().lower()
    if normalized in {"1", "true", "yes", "on"}:
        return True
    if normalized in {"0", "false", "no", "off"}:
        return False
    raise ValueError(f"{name} must be a boolean value")


@dataclass(frozen=True)
class Settings:
    environment: str
    debug: bool
    port: int
    database_host: str
    database_port: int
    database_name: str
    database_user: str
    database_password: str
    secret_key: str
    session_minutes: int
    institutional_email_domain: str
    smtp_host: str
    smtp_port: int
    smtp_user: str
    smtp_password: str
    smtp_from: str
    auth_dev_code_output: bool


def load_settings() -> Settings:
    environment = os.getenv("FLASK_ENV", "development")
    secret_key = os.getenv("SECRET_KEY")
    if not secret_key and environment == "production":
        raise ValueError("SECRET_KEY is required in production")
    return Settings(
        environment=environment,
        debug=_read_bool("FLASK_DEBUG", False),
        port=int(os.getenv("FLASK_PORT", "5000")),
        database_host=os.getenv("DATABASE_HOST", "localhost"),
        database_port=int(os.getenv("DATABASE_PORT", "5432")),
        database_name=os.getenv("DATABASE_NAME", "nexo"),
        database_user=os.getenv("DATABASE_USER", "postgres"),
        database_password=os.getenv("DATABASE_PASSWORD", ""),
        secret_key=secret_key or secrets.token_urlsafe(32),
        session_minutes=int(os.getenv("SESSION_MINUTES", "60")),
        institutional_email_domain=os.getenv(
            "INSTITUTIONAL_EMAIL_DOMAIN", "huixquilucan.tecnm.mx"
        ),
        smtp_host=os.getenv("SMTP_HOST", ""),
        smtp_port=int(os.getenv("SMTP_PORT", "587")),
        smtp_user=os.getenv("SMTP_USER", ""),
        smtp_password=os.getenv("SMTP_PASSWORD", ""),
        smtp_from=os.getenv("SMTP_FROM", ""),
        auth_dev_code_output=_read_bool("AUTH_DEV_CODE_OUTPUT", False),
    )


settings = load_settings()
