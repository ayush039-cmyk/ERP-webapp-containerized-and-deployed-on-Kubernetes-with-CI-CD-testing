#!/bin/sh
set -e

python manage.py migrate

python manage.py createsuperuser --noinput || true

exec "$@"

