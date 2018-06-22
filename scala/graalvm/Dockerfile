FROM artsy/graalvm

ENV SCALA_VERSION=2.12.4 \
    SBT_VERSION=0.13.17

RUN apt-get update -qq && apt-get install -y curl postgresql-client awscli jq

RUN cd "/tmp" && \
    curl -q -L -O https://piccolo.link/sbt-${SBT_VERSION}.tgz && \
    tar -zxf sbt-${SBT_VERSION}.tgz -C /usr/local && \
    curl -q -L -O https://downloads.lightbend.com/scala/${SCALA_VERSION}/scala-${SCALA_VERSION}.tgz && \
    tar -zxf scala-${SCALA_VERSION}.tgz -C /usr/local && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN apt-get clean

ENV PATH=/usr/local/sbt/bin:/usr/local/scala-2.12.4/bin:$PATH

RUN scala -version && \
    sbt about
