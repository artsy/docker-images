FROM amazoncorretto:8

ENV SCALA_VERSION=2.12.7 \
    DOCKERIZE_VERSION=v0.6.1

RUN curl -L https://www.scala-sbt.org/sbt-rpm.repo | tee /etc/yum.repos.d/scala-sbt-rpm.repo

RUN yum install -y wget tar gzip awscli jq sbt

RUN cd /tmp && \
    wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

RUN cd /tmp && \
    curl -q -L -O https://downloads.lightbend.com/scala/${SCALA_VERSION}/scala-${SCALA_VERSION}.tgz && \
    tar -zxf scala-${SCALA_VERSION}.tgz -C /usr/local

ENV PATH=/usr/local/scala-$SCALA_VERSION/bin:$PATH

WORKDIR /home

RUN scala -version
