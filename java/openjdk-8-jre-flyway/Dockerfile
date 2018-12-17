FROM openjdk:8-jre-slim

ENV LANG C.UTF-8

ADD https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/4.1.2/flyway-commandline-4.1.2-linux-x64.tar.gz /tmp/flyway.tar.gz
RUN mkdir -p /opt/flyway && \
  tar xf /tmp/flyway.tar.gz -C /opt/flyway --strip-components=1 \
  && chmod 755 /opt/flyway/flyway
