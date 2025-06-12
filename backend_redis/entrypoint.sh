#!/bin/bash
set -e

MAX_TRIES=${MAX_TRIES:-30}
TRIES=0

echo "Waiting for Redis to be ready (timeout: ${MAX_TRIES}s)..."
until python -c "import redis; redis.StrictRedis(host='${REDIS_HOST:-redis}', port=${REDIS_PORT:-6379}).ping()" 2>/dev/null; do
  TRIES=$((TRIES + 1))
  if [ $TRIES -ge $MAX_TRIES ]; then
    echo "Redis not available after ${MAX_TRIES} seconds. Exiting."
    exit 1
  fi
  echo "Attempt $TRIES/$MAX_TRIES failed. Retrying in 1s..."
  sleep 1
done

echo "Starting Gunicorn server on port $PORT..."
exec gunicorn backend_redis.wsgi:application \
    --bind 0.0.0.0:${PORT:-8001} \
    --workers 3
