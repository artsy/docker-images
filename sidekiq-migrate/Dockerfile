FROM ruby:2.6.2

RUN gem install redis json

COPY migrate.rb /migrate.rb

CMD ["ruby" "migrate.rb"]
