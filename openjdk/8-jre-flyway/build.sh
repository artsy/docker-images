#!/bin/bash

docker build -t artsy/openjdk:8-jre-flyway .
docker login
docker push artsy/openjdk:8-jre-flyway
