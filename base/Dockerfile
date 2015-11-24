FROM debian:jessie

RUN apt-get update -qq && apt-get install -y --no-install-recommends \
  ca-certificates \
  curl \
  wget \
  mongodb-clients \
  build-essential \
  libpq-dev \
  && rm -rf /var/lib/apt/lists/*
