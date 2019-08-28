FROM amazoncorretto:11

ENV SCALA_VERSION=2.12.8
ENV LANG C.UTF-8

RUN curl https://bintray.com/sbt/rpm/rpm | tee /etc/yum.repos.d/bintray-sbt-rpm.repo

RUN yum install -y nginx procps tar gzip sbt && yum clean all

# set up flyway for runtime migrations
ADD https://repo1.maven.org/maven2/org/flywaydb/flyway-commandline/6.0.0/flyway-commandline-6.0.0-linux-x64.tar.gz /tmp/flyway.tar.gz

RUN mkdir -p /opt/flyway && \
  tar zxf /tmp/flyway.tar.gz -C /opt/flyway --strip-components=1 \
  && chmod 755 /opt/flyway/flyway

RUN cd /tmp && \
    curl -q -L -O https://downloads.lightbend.com/scala/${SCALA_VERSION}/scala-${SCALA_VERSION}.tgz && \
    tar -zxf scala-${SCALA_VERSION}.tgz -C /usr/local

ENV PATH=/usr/local/scala-$SCALA_VERSION/bin:$PATH

# run these commands to make sure all SBT and Scala JARs are downloaded
RUN scala -version && \
    sbt about
