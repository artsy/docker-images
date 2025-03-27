#!/bin/bash

# Usage: ./export-db.sh { ARCHIVE_NAME } { PG_DUMP_ARGS }

set -e

if test -z "$1"
then
  echo "You must supply an archive name as an argument"
  exit 1
fi

ARCHIVE_NAME=$1
echo "Using archive name: $ARCHIVE_NAME"

if [ $# -gt 1 ]; then
  PG_DUMP_ARGS="${@:2}"
else
  PG_DUMP_ARGS="-O -Fc -v"
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

# if AWS_ID and AWS_SECRET are set and not empty, use them
# otherwise, use the standard AWS credentials from the env
if test -n "$AWS_ID" && test -n "$AWS_SECRET"
then
  export AWS_ACCESS_KEY_ID=$AWS_ID
  export AWS_SECRET_ACCESS_KEY=$AWS_SECRET
else
  if test -z "$AWS_ACCESS_KEY_ID" || test -z "$AWS_SECRET_ACCESS_KEY"
  then
    echo "AWS credentials must be set!"
    exit 1
  fi
fi

start_datetime=$(date -u +"%D %T %Z")
echo "[pg_dump] Starting at: $start_datetime"
echo "[pg_dump] Running with args: $PG_DUMP_ARGS"

pg_dump -d $DATABASE_URL -f /tmp/archive.pgdump $PG_DUMP_ARGS
ls -l /tmp/archive.pgdump

end_datetime=$(date -u +"%D %T %Z")
echo "[pg_dump] Ended at: $end_datetime"

start_datetime=$(date -u +"%D %T %Z")
echo "[S3 upload] Starting at: $start_datetime"

if [ "$USE_ARCHIVE_TIMESTAMP" = "1" ]; then
  timestamp=`date +%m-%d-%Y--%H-%M-%S`
  aws s3 cp --no-progress /tmp/archive.pgdump s3://artsy-data/$APP_NAME/$ARCHIVE_NAME--$timestamp.pgdump
  aws s3 ls s3://artsy-data/$APP_NAME/$ARCHIVE_NAME--$timestamp.pgdump
else
  aws s3 cp --no-progress /tmp/archive.pgdump s3://artsy-data/$APP_NAME/$ARCHIVE_NAME.pgdump
  aws s3 ls s3://artsy-data/$APP_NAME/$ARCHIVE_NAME.pgdump
fi

end_datetime=$(date -u +"%D %T %Z")
echo "[S3 upload] Ended at: $end_datetime"
