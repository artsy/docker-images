FROM ruby:2.6.6-alpine3.12

# Install Node + Yarn
ENV NODE_VERSION 12.20.1
ENV YARN_VERSION 1.22.5

RUN addgroup -g 1000 node \
  && adduser -u 1000 -G node -s /bin/sh -D node \
  && apk add --no-cache libstdc++ \
  && apk add --no-cache --virtual .build-deps curl \
  && curl -fsSLO --compressed "https://unofficial-builds.nodejs.org/download/release/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64-musl.tar.xz" \
  && tar -xJf "node-v$NODE_VERSION-linux-x64-musl.tar.xz" -C /usr/local --strip-components=1 --no-same-owner \
  && ln -s /usr/local/bin/node /usr/local/bin/nodejs \
  && rm -f "node-v$NODE_VERSION-linux-x64-musl.tar.xz" \
  && apk del .build-deps

RUN apk add --no-cache --virtual .build-deps-yarn curl gnupg tar \
  && for key in \
  6A010C5166006599AA17F08146C2130DFD2497F5 \
  ; do \
  gpg --batch --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys "$key" || \
  gpg --batch --keyserver hkp://ipv4.pool.sks-keyservers.net --recv-keys "$key" || \
  gpg --batch --keyserver hkp://pgp.mit.edu:80 --recv-keys "$key" ; \
  done \
  && curl -fsSLO --compressed "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz" \
  && curl -fsSLO --compressed "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz.asc" \
  && gpg --batch --verify yarn-v$YARN_VERSION.tar.gz.asc yarn-v$YARN_VERSION.tar.gz \
  && mkdir -p /opt \
  && tar -xzf yarn-v$YARN_VERSION.tar.gz -C /opt/ \
  && ln -s /opt/yarn-v$YARN_VERSION/bin/yarn /usr/local/bin/yarn \
  && ln -s /opt/yarn-v$YARN_VERSION/bin/yarnpkg /usr/local/bin/yarnpkg \
  && rm yarn-v$YARN_VERSION.tar.gz.asc yarn-v$YARN_VERSION.tar.gz \
  && apk del .build-deps-yarn
