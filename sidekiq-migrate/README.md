# Sidekiq Migrate

Dockerfile and scripts for migrating Sidekiq queues from an old to new Redis instance

## Use

Default Dockerfile command: `ruby migrate.rb`

```
docker run --env "SIDEKIQ_OLD_REDIS_URL=redis://host/database" --env "SIDEKIQ_NEW_REDIS_URL=redis://host/database" artsy/sidekiq-migrate:latest
```

### Required enviornment variables:

- `SIDEKIQ_OLD_REDIS_URL`
- `SIDEKIQ_NEW_REDIS_URL`

### Optional enviornment variables:

- `DRY_RUN`

If set to "true", `migrate.rb` will print a summary of queues, retry / scheduled sets and stats to the new Redis instance

- `CLEAN_UP`

If set to "true", `migrate.rb` will remove the keys in the old Redis database

- `DEBUG`

If set to "true", `migrate.rb` will print moved jobs.
