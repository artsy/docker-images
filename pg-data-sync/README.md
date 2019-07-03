# Postgres Data-Sync

Dockerfile and scripts for exporting and importing Postgres databases

# Use

Set the env var `APP_NAME` to the name of your application

Set the env var `DATABASE_URL` to a Postgres connection string pointing to the target database

Set the env vars `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` with credentials to upload archives to S3

## Export

Invoke `./export-db.sh` with the name of the archive (i.e. "staging" or "latest") to create in S3 - additional arguments are passed to `pg_dump`

## Import

Invoke `./import-db.sh` with the name of the archive (i.e. "staging" or "latest") to restore from S3 - additional arguments are passed to `pg_restore`
