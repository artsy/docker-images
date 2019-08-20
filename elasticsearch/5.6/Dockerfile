FROM docker.elastic.co/elasticsearch/elasticsearch:5.6.16
COPY artsy-similarity-plugin-1.0 /usr/share/elasticsearch/plugins/artsy-similarity-plugin-1.0
RUN /usr/share/elasticsearch/bin/elasticsearch-plugin list

COPY es-wrapper.sh bin/es-wrapper.sh
CMD ["/bin/bash", "bin/es-wrapper.sh"]
