#!/bin/bash

# Use: ./build.sh

build_version () {
  cat <<EOF > Dockerfile
FROM postgres:$1

RUN apt-get update -qq && apt-get install -y awscli && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD export-db.sh .
ADD import-db.sh .

CMD ["sh", "./export-db.sh", "latest"]
EOF

docker build -t artsy/pg-data-sync .
docker tag artsy/pg-data-sync:latest artsy/pg-data-sync:$1
docker push artsy/pg-data-sync:$1

}

build_version '9.5'
build_version '9.6'
build_version '10'
build_version '11'
build_version '12'
