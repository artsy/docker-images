#!/bin/bash

DIR=`pwd`

for IMAGE in alpine-glibc alpline-oraclejdk8 alpine-scala
do
  cd $DIR/$IMAGE
  docker build -t artsy/$IMAGE .
done



