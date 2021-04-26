FROM debian:10

ENV LANG=C.UTF-8

# base
RUN apt-get update -qq && apt-get install -y \
  bzip2 \
  bzr \
  curl \
  git \
  mercurial \
  openssh-client \
  procps \
  subversion \
  unzip \
  wget \
  xz-utils \
  zip

# openjdk
RUN apt-get update -qq && apt-get install -y \
  apt-transport-https \
  ca-certificates \
  dirmngr \
  gnupg \
  software-properties-common

RUN wget -qO - https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | apt-key add - && \
    add-apt-repository --yes https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/ && \
    apt-get update -qq && apt-get install -y \
      adoptopenjdk-8-hotspot

# python3
RUN apt-get update -qq && apt-get install -y \
  python3 \
  python3-pip \
  python3-venv

RUN pip3 install hokusai

# python2
RUN apt-get update -qq && apt-get install -y \
  python2 \
  python-pip

# virtualenv
RUN apt-get update -qq && apt-get install -y \
  virtualenv

# dumb-init
RUN apt-get update -qq && apt-get install -y \
  dumb-init

# jenkins war
RUN mkdir /opt/jenkins && \
    wget --quiet -O /opt/jenkins/jenkins-1.658.war https://s3.amazonaws.com/artsy-provisioning-public/jenkins-1.658.war && \
    ln -s /opt/jenkins/jenkins-1.658.war /opt/jenkins/jenkins.war

# iam authenticator
RUN curl -s -o /tmp/aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.19.6/2021-01-05/bin/linux/amd64/aws-iam-authenticator && \
    chmod +x /tmp/aws-iam-authenticator && \
    mv /tmp/aws-iam-authenticator /usr/local/bin

# jenkins user/group
RUN groupadd -g 1000 jenkins && \
    useradd -d /var/lib/jenkins -u 1000 -g 1000 -m -s /bin/bash jenkins && \
    chown -R jenkins:jenkins /var/lib/jenkins

USER jenkins
WORKDIR /var/lib/jenkins

# entrypoint
ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["java", "-Djava.awt.headless=true", "-XX:MaxPermSize=512m", "-XX:+CMSPermGenSweepingEnabled", "-XX:+CMSClassUnloadingEnabled", "-XX:+UseConcMarkSweepGC", "-jar", "/opt/jenkins/jenkins-1.658.war", "--httpPort=8080", "--httpListenAddress=0.0.0.0", "--ajp13Port=-1"]
