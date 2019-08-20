#!/bin/bash

start() {
    bin/es-docker &
    pid="$!"
    wait
}

stop() {
    kill $pid
    echo "Caught SIGTERM - sleeping 10 seconds before shutdown..."
    sleep 10
}

trap stop SIGTERM
start
