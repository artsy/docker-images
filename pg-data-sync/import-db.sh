#!/bin/bash

# Usage: ./import-db.sh { ARCHIVE_NAME } { PG_RESTORE_ARGS }

if test -z "$1"
then
  echo "You must supply an archive name as an argument"
  exit 1
fi

ARCHIVE_NAME=$1

if test -z "$2"
then
  PG_RESTORE_ARGS="--clean --if-exists --no-owner --no-privileges --schema=public -v"
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
echo "[S3 download] Starting at $start_datetime"

aws s3 ls s3://artsy-data/$APP_NAME/$ARCHIVE_NAME.pgdump
aws s3 cp --no-progress s3://artsy-data/$APP_NAME/$ARCHIVE_NAME.pgdump /tmp/archive.pgdump
ls -l /tmp/archive.pgdump

end_datetime=$(date -u +"%D %T %Z")
echo "[S3 download] Ended at $end_datetime"

start_datetime=$(date -u +"%D %T %Z")
echo "[pg_restore] Starting at $start_datetime"

pg_restore /tmp/archive.pgdump -d $DATABASE_URL $PG_RESTORE_ARGS
PG_EXIT_CODE=$?

end_datetime=$(date -u +"%D %T %Z")
echo "[pg_restore] Ended at $end_datetime"

if [ "$SWALLOW_ERRORS_ON_RESTORE" = "1" ]; then
  echo "SWALLOW_ERRORS_ON_RESTORE is 1. Exiting script with return code 0."
  exit 0
else
  echo "Exiting script with pg_restore return code of $PG_EXIT_CODE"
  exit $PG_EXIT_CODE
fi
