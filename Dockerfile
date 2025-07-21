# Use latest stable slim Python image
FROM python:3.12-slim AS base

# Prevents Python from writing .pyc files and buffering stdout/stderr
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Install system dependencies
RUN apt-get update \
    && apt-get install --no-install-recommends -y \
       build-essential \
       curl \
    && rm -rf /var/lib/apt/lists/*

RUN pip install pytest

# Create a non-root user
RUN useradd -m -u 1000 appuser

# Set working directory
WORKDIR /app

# Copy dependency files first to leverage Docker cache
COPY pyproject.toml poetry.lock* ./

# Install Poetry
RUN curl -sSL https://install.python-poetry.org | python3 - \
    && mv ~/.local/bin/poetry /usr/local/bin/poetry

# Install only production dependencies
RUN poetry config virtualenvs.create false \
    && poetry install --only main --no-root --no-interaction

# Copy the application
COPY . .

# Set permissions
RUN chown -R appuser:appuser /app

# Use non-root user
USER appuser

# Default command (adjust if needed)
ENTRYPOINT ["python", "app/main.py"]
