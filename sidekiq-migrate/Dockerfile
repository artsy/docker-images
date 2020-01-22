FROM ruby:2.6.2

RUN gem install redis json

COPY migrate.rb /migrate.rb

CMD /usr/local/bin/ruby /migrate.rb
