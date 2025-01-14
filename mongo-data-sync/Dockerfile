FROM mongo:6

RUN apt-get update -qq && apt-get install -y awscli dumb-init && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD export-db.sh .
ADD import-db.sh .
ADD load-secrets-and-run.sh ./load-secrets-and-run.sh

ENTRYPOINT [ "dumb-init", "./load-secrets-and-run.sh" ]
CMD ["sh", "./export-db.sh", "latest"]
