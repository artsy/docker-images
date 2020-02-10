#!/bin/bash

# Usage: ./import-db.sh { ARCHIVE_NAME }

set -e

if test -z "$1"
then
  echo "You must supply an archive name as an argument"
  exit 1
fi

ARCHIVE_NAME=$1

if test -z "$MONGOHQ_URL"
then
  echo "This script restores an archive from MONGOHQ_URL so it must be set!"
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
echo "[data import] Starting at $start_datetime"

aws s3 cp s3://artsy-data/$APP_NAME/$ARCHIVE_NAME.tar.gz archive.tar.gz

mongorestore --uri="$MONGOHQ_URL" --stopOnError --drop --gzip --archive=archive.tar.gz

end_datetime=$(date -u +"%D %T %Z")
echo "[data import] Ended at $end_datetime"
