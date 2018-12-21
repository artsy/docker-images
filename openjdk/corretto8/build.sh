#!/bin/bash

docker build -t artsy/openjdk:corretto8 -f Dockerfile.jvm .
docker build -t artsy/openjdk:corretto8-jre -f Dockerfile.jre .
docker login
docker push artsy/openjdk:corretto8
docker push artsy/openjdk:corretto8-jre
