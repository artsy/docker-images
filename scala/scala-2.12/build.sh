#!/bin/bash

docker build -t artsy/scala:2.12 .
docker build -t artsy/scala:2.12-node -f Dockerfile.node .
docker login
docker push artsy/scala:2.12
docker push artsy/scala:2.12-node
