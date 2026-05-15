#!/bin/sh
set -e

# ждать доступности Postgres
until nc -z $DATABASE_HOST $DATABASE_PORT; do
  echo "Waiting for Postgres..."
  sleep 1
done

# применить миграции и собрать статику (если нужно)
python manage.py migrate --noinput
python manage.py collectstatic --noinput || true

# запустить gunicorn (передается из CMD/command)
exec "$@"