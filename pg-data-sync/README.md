# Postgres Data-Sync

Dockerfile and scripts for exporting and importing Postgres databases

# Use

Set the env var `APP_NAME` to the name of your application

Set the env var `DATABASE_URL` to a Postgres connection string pointing to the target database

Set the env vars `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` with credentials to upload archives to S3

## Export

- Invoke `./export-db.sh` with the name of the archive as an argument (i.e. "staging" or "latest") providing the filename to create in S3.

- Optionally provide a second argument as a quoted string to override the default export options "-O -Fc"

## Import

- Invoke `./import-db.sh` with the name of the archive as an argument (i.e. "staging" or "latest") providing the filename to restore from S3.

- Optionally provide a second argument as a quoted string to override the default import options "--clean --no-owner --no-privileges --schema=public"
