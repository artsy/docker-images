FROM circleci/ruby:2.4.1-node-browsers
ARG BUNDLE_GITHUB__COM

# Install dependencies
RUN sudo apt-get update && \
    sudo apt-get install -y qt5-default libqt5webkit5-dev gstreamer1.0-plugins-base gstreamer1.0-tools gstreamer1.0-x xvfb

RUN gem update --system && \
    gem install bundler
