# custom amd64 elasticsearch v6.8.23 image
FROM elasticsearch:6.8.23

RUN useradd -m elasticuser

COPY elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml

WORKDIR /usr/share/elasticsearch

RUN chown -R elasticuser: .

USER elasticuser

EXPOSE 9200 9300
CMD ["elasticsearch"]
