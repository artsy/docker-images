FROM mongo:4.4

RUN apt-get update -qq && apt-get install -y awscli && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD export-db.sh .
ADD import-db.sh .

CMD ["sh", "./export-db.sh", "latest"]
