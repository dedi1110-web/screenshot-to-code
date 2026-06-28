FROM python:3.12.3-slim-bookworm

ENV POETRY_VERSION=1.8.0
RUN pip install "poetry==$POETRY_VERSION"

WORKDIR /app

COPY backend/poetry.lock backend/pyproject.toml /app/
RUN poetry config virtualenvs.create false && \
    poetry install --no-interaction --no-ansi && \
    playwright install --with-deps chromium

COPY backend/ /app/

EXPOSE 7860
CMD ["poetry", "run", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "7860"]
