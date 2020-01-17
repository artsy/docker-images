# Sidekiq Migrate

Dockerfile and scripts for migrating Sidekiq queues from an old to new Redis instance

## Use

Default Dockerfile command: `ruby migrate.rb`

### Required enviornment variables:

- `SIDEKIQ_OLD_REDIS_URL`
- `SIDEKIQ_NEW_REDIS_URL`

If *only* these are supplied, `migrate.rb` will make a dry run

### Optional enviornment variables:

- `ACTUAL_RUN`

If set to "true", `migrate.rb` will copy all queues and retry / scheduled sets to the new Redis instance

- `CLEAN_UP`

If also set to "true", `migrate.rb` will remove they keys in the old Redis (only applies when `ACTUAL_RUN` is also true)
