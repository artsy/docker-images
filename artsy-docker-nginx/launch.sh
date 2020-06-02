#!/bin/sh

rm -f /etc/nginx/conf.d/default.conf || :
envsubst '\$NGINX_DEFAULT_CONF' < default.conf > /etc/nginx/conf.d/default.conf
envsubst '\$HTPASSWD' < .htpasswd > /etc/nginx/.htpasswd

nginx -g "daemon off;"
