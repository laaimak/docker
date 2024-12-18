#!/bin/sh

set -e

echo "Waiting for MySQL..."

while ! nc -z mysql_db 3306; do
  sleep 1
done

echo "MySQL is up - executing command"
exec "$@"
