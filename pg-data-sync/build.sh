#!/bin/bash

# Use: ./build.sh

build_version () {

  APT_PACKAGES="python3 curl"

  if [[ $1 == '12' ]]
  then
    APT_PACKAGES=$APT_PACKAGES" python3-distutils"
  fi

  cat <<EOF > Dockerfile
FROM postgres:$1

RUN apt-get update -qq && apt-get install -y $APT_PACKAGES && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl -O https://bootstrap.pypa.io/get-pip.py
RUN python3 get-pip.py
RUN pip3 install awscli --upgrade

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
