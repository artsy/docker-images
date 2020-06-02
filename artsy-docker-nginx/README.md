# artsy-docker-nginx
----
> A simple image providing a Nginx container with config populated from an environment variable.

## Use
> Set the environment variable `NGINX_DEFAULT_CONF` to the configuration you wish written to `/etc/nginx/conf.d/default.conf`.

> Set the environment variable `HTPASSWD` and its contents will be written to `/etc/nginx/.htpasswd`, so you can use it in your configuration.
