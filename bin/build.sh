#!/bin/bash

set -e

DIR=`pwd`

for IMAGE in alpine-glibc alpine-oraclejdk8 alpine-scala
do
  cd $DIR/$IMAGE
  docker build -t artsy/$IMAGE .
done



