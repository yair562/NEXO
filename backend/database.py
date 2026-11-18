from collections.abc import Iterator
from contextlib import contextmanager

import psycopg

from backend.config import Settings, settings


class DatabaseConnectionError(RuntimeError):
    """Raised when PostgreSQL cannot be reached with the configured settings."""


def connection_parameters(config: Settings = settings) -> dict[str, object]:
    return {
        "host": config.database_host,
        "port": config.database_port,
        "dbname": config.database_name,
        "user": config.database_user,
        "password": config.database_password,
    }


@contextmanager
def get_connection(config: Settings = settings) -> Iterator[psycopg.Connection]:
    try:
        connection = psycopg.connect(**connection_parameters(config))
    except psycopg.Error as error:
        raise DatabaseConnectionError("Unable to connect to PostgreSQL") from error

    try:
        yield connection
    finally:
        connection.close()
