FROM golang:1.10.3-stretch

RUN apt-get update -qq && apt-get install -y flex bison curl wget procps net-tools tcpdump netcat && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set up dumb-init
ADD https://github.com/Yelp/dumb-init/releases/download/v1.2.0/dumb-init_1.2.0_amd64 /usr/local/bin/dumb-init
RUN chmod +x /usr/local/bin/dumb-init

# Compile goreplay
RUN wget http://www.tcpdump.org/release/libpcap-1.8.1.tar.gz && tar xzf libpcap-1.8.1.tar.gz && cd libpcap-1.8.1 && ./configure && make install
RUN go get github.com/google/gopacket
RUN go get github.com/buger/gor

WORKDIR $GOPATH/src/github.com/buger/goreplay/
RUN go build -ldflags "-X main.VERSION=0.16.2-alpha -extldflags \"-static\""
RUN chmod +x goreplay
RUN mv goreplay /usr/local/bin/goreplay

ENTRYPOINT ["/usr/local/bin/dumb-init", "--"]
CMD ["/usr/local/bin/goreplay", "--input-tcp", ":80", "--output-stdout"]
