FROM  debian:stretch

ENV GRAAL_VERSION=1.0.0-rc8
ENV GRAAL_CE_URL=https://github.com/oracle/graal/releases/download/vm-${GRAAL_VERSION}/graalvm-ce-${GRAAL_VERSION}-linux-amd64.tar.gz
ENV DOCKERIZE_VERSION v0.6.1
RUN apt-get update && \
    apt-get install -y wget tar gzip

RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

RUN   cd /tmp && \
      wget -q $GRAAL_CE_URL -O graalvm-ce-linux-amd64.tar.gz && \
      tar -xvzf graalvm-ce-linux-amd64.tar.gz && \
      mkdir -p /usr/lib/jvm/graalvm && \
      mv graalvm-ce-${GRAAL_VERSION} /usr/lib/jvm/graalvm && \
      rm graalvm-ce-linux-amd64.tar.gz && \
      rm -rf /usr/lib/jvm/graalvm/doc && \
      rm -rf /usr/lib/jvm/graalvm/man && \
      rm -rf /usr/lib/jvm/graalvm/src.zip && \
      rm -rf /tmp/*

RUN   apt-get clean

ENV   JAVA_HOME=/usr/lib/jvm/graalvm/graalvm-ce-${GRAAL_VERSION}
ENV   PATH=$PATH:$JAVA_HOME/bin
ENV   GRAALVM_HOME=/usr/lib/jvm/graalvm/graalvm-ce-${GRAAL_VERSION}
