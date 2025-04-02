#!/bin/bash

# Use: ./build.sh

set -e

docker build -t artsy/artsy-fluentd .

docker login

docker push artsy/artsy-fluentd:latest
