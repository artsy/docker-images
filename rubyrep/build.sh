#!/bin/bash

# Use: ./build.sh

docker build . -t artsy/rubyrep:mri
docker push artsy/rubyrep:mri

