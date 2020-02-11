# Easy peasy Redis migration

Utility for migrating all Redis keys to a new instance when you can't use MIGRATE ... I'm lookin' at you AWS >:(

## Use (Requires VPN)
`docker run artsy/redis-migrate:latest` `SOURCE_REDIS_URL` `DESTINATION_REDIS_URL`

`SOURCE_REDIS_URL` / `DESTINATION_REDIS_URL` should be in the form of `redis://host:port/database`, i.e. `redis://localhost:6379/0`

### Additional environment options

Set the env var `DEBUG=1` to enable debug logging

Set the env var `DRY_RUN=1` to make a dry run

Set the env var `REPLACE_DST_KEYS=1` to force overwrite of keys in the destination database - otherwise if a key already exists, restore fails to overwrite an existing key and an error message is printed

Set the env var `CLEAN_UP=1` to delete keys in the source database if sucessfully migrated to the destination database

Pass environment variables directly after the `run` command like so:
`docker run --env "DRY_RUN=1" --env "DEBUG=1" artsy/redis-migrate:latest "SOURCE_REDIS_URL" "DESTINATION_REDIS_URL"`

### Confirming records
Use the `redis-cli` to connect directly to the database and ensure the expected number of records are present. 

Connect to database:
`redis-cli -h <host> -n <database>`

Get database keys:
`KEYS *`

Credit goes to @josegonzalez for the source code in [this gist](https://gist.github.com/josegonzalez/6049a72cb163337a18102743061dfcac) - just made some slight tweaks and packaged it up here so to be able to run in container environments
