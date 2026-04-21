#!/bin/sh
set -e

GUNICORN_WORKERS=${GUNICORN_WORKERS:-5}
GUNICORN_BIND=${GUNICORN_BIND:-"0.0.0.0:5000"}
GUNICORN_TIMEOUT=${GUNICORN_TIMEOUT:-500}

COMMAND=${1:-""}

case "$COMMAND" in
    start)
        exec gunicorn -w "$GUNICORN_WORKERS" decide.wsgi --timeout="$GUNICORN_TIMEOUT" -b "$GUNICORN_BIND"
        ;;
    migrate)
        exec python manage.py migrate
        ;;
    collectstatic)
        exec python manage.py collectstatic --noinput
        ;;
    manage)
        shift
        exec python manage.py "$@"
        ;;
    *)
        python manage.py migrate
        exec gunicorn -w "$GUNICORN_WORKERS" decide.wsgi --timeout="$GUNICORN_TIMEOUT" -b "$GUNICORN_BIND"
        ;;
esac
