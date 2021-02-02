FROM ruby:2.6.5-alpine3.10

WORKDIR /rubyrep

RUN apk update && apk --no-cache --quiet add --update \
      build-base \
      postgresql-dev \
      bash

COPY .ruby-version Gemfile* ./

RUN gem install bundler && \
    bundle install --frozen --jobs $(nproc)

CMD ["/rubyrep-2.0.1/rubyrep", "--verbose", "scan", "-c", "/mnt/default.conf", "--summary"]

