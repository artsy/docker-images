#!/bin/bash

# Use: ./build.sh

set -e

docker build -t artsy/docker-nginx .

docker login

docker push artsy/docker-nginx:latest
