FROM python:3.14.6-slim-bookworm

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir --disable-pip-version-check -r requirements.txt

COPY backend ./backend
COPY frontend ./frontend
COPY scripts ./scripts

RUN useradd --create-home --uid 10001 appuser \
    && chown -R appuser:appuser /app

USER appuser

EXPOSE 5000

CMD ["python", "-m", "backend.app"]
