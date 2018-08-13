FROM debian:stretch

RUN apt-get update -qq && apt-get install -y curl procps net-tools tcpdump netcat && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set up dumb-init
ADD https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64 /usr/local/bin/dumb-init
RUN chmod +x /usr/local/bin/dumb-init

ADD https://github.com/buger/goreplay/releases/download/v0.16.1/gor_0.16.1_x64.tar.gz /tmp/goreplay.tar.gz
RUN tar xfvz /tmp/goreplay.tar.gz
RUN mv goreplay /usr/local/bin/
RUN rm -f /tmp/goreplay.tar.gz

ENTRYPOINT ["/usr/local/bin/dumb-init", "--"]
CMD ["/usr/local/bin/goreplay", "--input-tcp", ":80", "--output-stdout"]
