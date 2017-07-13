#!/bin/bash

set -e

DIR=`pwd`

for IMAGE in alpine-glibc alpine-oraclejdk8 alpine-scala ruby-2-3-3-with-qt5 ruby-2-4-1-with-qt5
do
  cd $DIR/$IMAGE
  docker build -t artsy/$IMAGE .
done



