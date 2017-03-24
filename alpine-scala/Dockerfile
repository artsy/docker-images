FROM artsy/alpine-oraclejdk8

ENV SCALA_VERSION=2.11.8 \
    SCALA_HOME=/usr/share/scala \
    SBT_VERSION=0.13.11 \
    SBT_HOME=/usr/local/sbt \
    PATH=${PATH}:${SBT_HOME}/bin

# NOTE: bash is used by scala/scalac scripts, and it cannot be easily replaced with ash.

RUN apk add --no-cache --virtual=.build-dependencies wget ca-certificates && \
    apk add --no-cache bash && \
    cd "/tmp" && \
    wget -q "https://downloads.typesafe.com/scala/${SCALA_VERSION}/scala-${SCALA_VERSION}.tgz" && \
    tar xzf "scala-${SCALA_VERSION}.tgz" && \
    mkdir "${SCALA_HOME}" && \
    rm "/tmp/scala-${SCALA_VERSION}/bin/"*.bat && \
    mv "/tmp/scala-${SCALA_VERSION}/bin" "/tmp/scala-${SCALA_VERSION}/lib" "${SCALA_HOME}" && \
    ln -s "${SCALA_HOME}/bin/"* "/usr/bin/" && \
    apk del .build-dependencies && \
    rm -rf "/tmp/"*

RUN cd /tmp && wget -q -O - "http://dl.bintray.com/sbt/native-packages/sbt/$SBT_VERSION/sbt-$SBT_VERSION.tgz" | gunzip | tar -x && \
    cp -a sbt/* /usr/local && rm -rf sbt && \
    echo -ne "- with sbt $SBT_VERSION\n" >> /root/.built