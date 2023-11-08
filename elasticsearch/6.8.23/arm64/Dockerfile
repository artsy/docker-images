# custom arm64 elasticsearch v6.8.23 image
# adopted from https://stackoverflow.com/questions/68877644/how-to-run-elasticsearch-6-on-an-apple-silicon-mac/70713284#70713284
FROM arm64v8/openjdk:8-jdk-slim-bullseye

WORKDIR /tmp

RUN useradd -m elasticuser

RUN apt update && apt install -y curl

RUN curl -L -O https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.8.23.tar.gz \
    && tar -xvf elasticsearch-6.8.23.tar.gz \
    && mv elasticsearch-6.8.23 /usr/share/elasticsearch \
    && rm -rf elasticsearch-6.8.23.tar.gz

ADD elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml

ENV PATH="/usr/share/elasticsearch/bin:${PATH}"

WORKDIR /usr/share/elasticsearch

RUN chown -R elasticuser: .

USER elasticuser

EXPOSE 9200 9300
CMD ["elasticsearch"]
