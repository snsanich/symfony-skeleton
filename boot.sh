#!/usr/bin/env bash

# Wait for postgres to start

host=$DATABASE_PORT_5432_TCP_ADDR
port=$DATABASE_PORT_5432_TCP_PORT

echo -n "waiting for TCP connection to database:..."

while ! nc -z -w 1 $host $port 2>/dev/null
do
  echo -n "."
  sleep 1
done

echo 'ok'

# Prepare application
app/console cache:clear
app/console doctr:migration:migrate -n

php-fpm
