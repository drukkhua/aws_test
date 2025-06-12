#!/bin/bash
set -e

MAX_TRIES=${MAX_TRIES:-30}
TRIES=0

echo "Waiting for PostgreSQL to be ready (timeout: ${MAX_TRIES}s)..."
until python -c "import psycopg2; psycopg2.connect(
    dbname='${DB_NAME:-app}',
    user='${DB_USER:-user}',
    password='${DB_PASSWORD:-password}',
    host='${DB_HOST:-db}',
    port=${DB_PORT:-5432}
)" 2>/dev/null; do
  TRIES=$((TRIES + 1))
  if [ $TRIES -ge $MAX_TRIES ]; then
    echo "PostgreSQL not available after ${MAX_TRIES} seconds. Exiting."
    exit 1
  fi
  echo "Attempt $TRIES/$MAX_TRIES failed. Retrying in 1s..."
  sleep 1
done

echo "Applying database migrations..."
python manage.py migrate --settings=backend_rds.settings

echo "Starting Gunicorn server on port $PORT..."
export DJANGO_SETTINGS_MODULE=backend_rds.settings
exec gunicorn backend_rds.wsgi:application \
    --bind 0.0.0.0:${PORT:-8000} \
    --workers 3
