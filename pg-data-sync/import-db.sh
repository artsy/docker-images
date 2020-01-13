#!/bin/bash

# Usage: ./import-db.sh { ARCHIVE_NAME } { PG_RESTORE_ARGS }

set -e

if test -z "$1"
then
  echo "You must supply an archive name as an argument"
  exit 1
fi

ARCHIVE_NAME=$1

if test -z "$2"
then
  PG_RESTORE_ARGS="--clean --no-owner --no-privileges --schema=public"
else
  PG_RESTORE_ARGS=$2
fi

if test -z "$DATABASE_URL"
then
  echo "This script restores an archive from DATABASE_URL so it must be set!"
  exit 1
fi

if test -z "$APP_NAME"
then
  echo "This script restores an archive for APP_NAME so it must be set!"
  exit 1
fi

if test -z "$AWS_ACCESS_KEY_ID" || test -z "$AWS_SECRET_ACCESS_KEY"
then
  echo "AWS credentials must be set!"
  exit 1
fi

start_datetime=$(date -u +"%D %T %Z")
echo "[data export] Starting at $start_datetime"

aws s3 cp s3://artsy-data/$APP_NAME/$ARCHIVE_NAME.pgdump archive.pgdump

pg_restore archive.pgdump -d $DATABASE_URL $PG_RESTORE_ARGS

end_datetime=$(date -u +"%D %T %Z")
echo "[data export] Ended at $end_datetime"
