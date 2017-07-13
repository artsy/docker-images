FROM ruby:2.4.1
ARG BUNDLE_GITHUB__COM

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash
# Install dependencies
RUN apt-get update && \
    apt-get install -y qt5-default libqt5webkit5-dev gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x xvfb

RUN apt-get install -y nodejs

RUN gem update --system && \
    gem install bundler

RUN npm -v