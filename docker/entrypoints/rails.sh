#!/bin/sh

set -x

# Remove a potentially pre-existing server.pid for Rails.
rm -rf /app/tmp/pids/server.pid
rm -rf /app/tmp/cache/*

echo "Waiting for postgres to become ready...."

# Let DATABASE_URL env take presedence over individual connection params.
# This is done to avoid printing the DATABASE_URL in the logs
eval $(docker/entrypoints/helpers/pg_database_url.rb)

# Debug: show what variables we have
echo "DEBUG: POSTGRES_HOST=$POSTGRES_HOST"
echo "DEBUG: POSTGRES_PORT=$POSTGRES_PORT" 
echo "DEBUG: POSTGRES_USERNAME=$POSTGRES_USERNAME"
echo "DEBUG: DATABASE_URL=$DATABASE_URL"

# Set defaults if variables are empty
: ${POSTGRES_HOST:=postgres}
: ${POSTGRES_PORT:=5432}
: ${POSTGRES_USERNAME:=postgres}

PG_READY="pg_isready -h $POSTGRES_HOST -p $POSTGRES_PORT -U $POSTGRES_USERNAME"

until $PG_READY
do
  sleep 2;
done

echo "Database ready to accept connections."

#install missing gems for local dev as we are using base image compiled for production
bundle install

BUNDLE="bundle check"

until $BUNDLE
do
  sleep 2;
done

# Execute the main process of the container
exec "$@"
