FROM buildpack-deps:jessie

RUN apt-get update -qq && apt-get install -y --no-install-recommends \
  mongodb-clients \
  postgresql-client \
  && rm -rf /var/lib/apt/lists/*
