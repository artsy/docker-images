#!/bin/bash

# Usage: ./export-db.sh { ARCHIVE_NAME } { PG_DUMP_ARGS }

set -e

if test -z "$1"
then
  echo "You must supply an archive name as an argument"
  exit 1
fi

ARCHIVE_NAME=$1

if test -z "$DATABASE_URL"
then
  echo "This script creates an archive from DATABASE_URL so it must be set!"
  exit 1
fi

if test -z "$APP_NAME"
then
  echo "This script creates an archive for APP_NAME so it must be set!"
  exit 1
fi

if test -z "$AWS_ACCESS_KEY_ID" || test -z "$AWS_SECRET_ACCESS_KEY"
then
  echo "AWS credentials must be set!"
  exit 1
fi

start_datetime=$(date -u +"%D %T %Z")
echo "[data export] Starting at $start_datetime"

pg_dump -O -Fc -d $DATABASE_URL -f archive.pgdump ${@:2}

aws s3 cp archive.pgdump s3://artsy-data/$APP_NAME/$ARCHIVE_NAME.pgdump

end_datetime=$(date -u +"%D %T %Z")
echo "[data export] Ended at $end_datetime"
