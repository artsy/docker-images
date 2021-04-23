#!/bin/bash

# Use: ./build.sh

docker build -t artsy/jenkins-master:latest .
docker push artsy/jenkins-master:latest
