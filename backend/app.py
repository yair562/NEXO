import secrets
from datetime import timedelta
from typing import Any, Callable

from flask import Flask, jsonify, render_template, request, session

from backend.config import PROJECT_ROOT, settings
from backend.database import DatabaseConnectionError, get_connection
from backend.auth import AuthError, authenticate, request_activation, set_password


def create_app() -> Flask:
    app = Flask(
        __name__,
        template_folder=str(PROJECT_ROOT / "frontend" / "templates"),
        static_folder=str(PROJECT_ROOT / "frontend" / "static"),
    )
    app.config.from_mapping(
        ENVIRONMENT=settings.environment,
        DEBUG=settings.debug,
        SECRET_KEY=settings.secret_key,
        PERMANENT_SESSION_LIFETIME=timedelta(minutes=settings.session_minutes),
        SESSION_COOKIE_HTTPONLY=True,
        SESSION_COOKIE_SAMESITE="Lax",
        SESSION_COOKIE_SECURE=settings.environment == "production",
    )

    @app.context_processor
    def security_context() -> dict[str, Callable[[], str]]:
        def csrf_token() -> str:
            token = session.get("_csrf_token")
            if not token:
                token = secrets.token_urlsafe(32)
                session["_csrf_token"] = token
            return token

        return {"csrf_token": csrf_token}

    @app.before_request
    def protect_state_changes() -> None:
        if request.method not in {"POST", "PUT", "PATCH", "DELETE"}:
            return
        token = request.headers.get("X-CSRF-Token") or request.form.get("csrf_token")
        expected = session.get("_csrf_token")
        if not token or not expected or not secrets.compare_digest(token, expected):
            if request.path.startswith("/api/"):
                raise AuthError("csrf_failed", "La solicitud no es válida.", 400)
            return

    @app.get("/api/health")
    def health() -> tuple[dict[str, str], int]:
        return {
            "status": "ok",
            "application": "NEXO",
            "message": "API funcionando correctamente",
        }, 200

    @app.get("/api/health/database")
    def database_health() -> tuple[dict[str, str], int]:
        try:
            with get_connection() as connection:
                with connection.cursor() as cursor:
                    cursor.execute(
                        "SELECT current_database(), current_user, version()"
                    )
                    cursor.fetchone()
        except DatabaseConnectionError:
            return {
                "status": "error",
                "database": "unavailable",
                "application": "NEXO",
            }, 503

        return {
            "status": "ok",
            "database": "connected",
            "application": "NEXO",
        }, 200

    @app.get("/")
    def login_page():
        return render_template("login.html")

    @app.get("/activate")
    def activation_page():
        return render_template("activate.html")

    @app.get("/api/auth/csrf")
    def csrf_endpoint():
        token = session.get("_csrf_token")
        if not token:
            token = secrets.token_urlsafe(32)
            session["_csrf_token"] = token
        return {"csrf_token": token}, 200

    @app.post("/api/auth/activation/request")
    def activation_request():
        payload = request.get_json(silent=True)
        if not isinstance(payload, dict):
            payload = {}
        result = request_activation(payload.get("matricula", ""), settings)
        response: dict[str, Any] = {
            "status": "ok",
            "message": "Si la matrícula está autorizada, recibirás un código institucional.",
        }
        if result.development_code is not None:
            response["development_code"] = result.development_code
            response["development_only"] = True
        return jsonify(response), 202

    @app.post("/api/auth/activation/password")
    def activation_password():
        payload = request.get_json(silent=True)
        if not isinstance(payload, dict):
            payload = {}
        set_password(
            payload.get("matricula", ""),
            payload.get("codigo", ""),
            payload.get("contrasena", ""),
            settings,
        )
        return {"status": "ok", "message": "Cuenta activada."}, 200

    @app.post("/api/auth/login")
    def login():
        payload = request.get_json(silent=True)
        if not isinstance(payload, dict):
            payload = {}
        account = authenticate(payload.get("matricula", ""), payload.get("contrasena", ""), settings)
        csrf = session.get("_csrf_token")
        session.clear()
        session["_csrf_token"] = csrf or secrets.token_urlsafe(32)
        session.permanent = True
        session["user_id"] = account["id"]
        session["matricula"] = account["matricula"]
        session["rol"] = account["rol"]
        return {
            "status": "ok",
            "matricula": account["matricula"],
            "rol": account["rol"],
        }, 200

    @app.post("/api/auth/logout")
    def logout():
        csrf = session.get("_csrf_token")
        session.clear()
        if csrf:
            session["_csrf_token"] = csrf
        return {"status": "ok"}, 200

    @app.get("/api/me")
    def current_user():
        if "user_id" not in session:
            return {"status": "error", "message": "Sesión requerida."}, 401
        return {
            "status": "ok",
            "matricula": session["matricula"],
            "rol": session["rol"],
        }, 200

    @app.get("/app")
    def application_home():
        if "user_id" not in session:
            return {"status": "error", "message": "Sesión requerida."}, 401
        return {
            "status": "ok",
            "message": "Sesión activa en NEXO.",
            "matricula": session["matricula"],
        }, 200

    @app.errorhandler(AuthError)
    def handle_auth_error(error: AuthError):
        return {"status": "error", "code": error.code, "message": error.message}, error.status

    return app


app = create_app()


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=settings.port, debug=settings.debug)
