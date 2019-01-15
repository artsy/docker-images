# The reason we create a new image and push to docker hub instead of just building off a
# base elasticsearch:2.4 image is that circleci currently does not support volume mapping
# in docker images (see link), which we need for elasticsearch.yml.
# (https://support.circleci.com/hc/en-us/articles/360007324514-How-can-I-mount-volumes-to-docker-containers-)
FROM elasticsearch:2.4
COPY elasticsearch.yml /usr/share/elasticsearch/config/elasticsearch.yml