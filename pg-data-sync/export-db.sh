#!/bin/bash

# Usage: ./export-db.sh { ARCHIVE_NAME } { PG_DUMP_ARGS }

set -e

if test -z "$1"
then
  echo "You must supply an archive name as an argument"
  exit 1
fi

ARCHIVE_NAME=$1

if test -z "$2"
then
  PG_DUMP_ARGS="-O -Fc -v"
else
  PG_DUMP_ARGS=$2
fi

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

pg_dump -d $DATABASE_URL -f /tmp/archive.pgdump $PG_DUMP_ARGS

if [ "$USE_ARCHIVE_TIMESTAMP" = "1" ]; then
  timestamp=`date +%m-%d-%Y--%l-%M-%S`
  aws s3 cp /tmp/archive.pgdump s3://artsy-data/$APP_NAME/$ARCHIVE_NAME--$timestamp.pgdump
else
  aws s3 cp /tmp/archive.pgdump s3://artsy-data/$APP_NAME/$ARCHIVE_NAME.pgdump
fi

end_datetime=$(date -u +"%D %T %Z")
echo "[data export] Ended at $end_datetime"
