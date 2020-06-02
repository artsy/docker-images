FROM nginx:stable-alpine

ENV NGINX_DEFAULT_CONF='server { listen 80 default_server; }'
ENV HTPASSWD=''

WORKDIR /opt

RUN apk add --no-cache gettext

COPY default.conf .htpasswd launch.sh ./

CMD ["./launch.sh"]
