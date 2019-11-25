# rubyrep Docker image

This image contains an installation of [rubyrep](http://www.rubyrep.org/) 2.0.1 running on JRuby 9.0

## Usage Example

1) Set the environment variables defined in `default.conf` to connect to your databases

2) Run a scan operation to check for differences

```
docker run artsy/rubyrep:latest
```

See http://www.rubyrep.org/tutorial.html for other operations, i.e. syncing and replicating two databases.
