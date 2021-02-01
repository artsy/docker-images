FROM ruby:2.2

RUN apt-get update && apt-get install unzip

RUN curl -L https://bintray.com/rubyrep/rubyrep/download_file?file_path=rubyrep-2.0.1.zip -o /tmp/rubyrep-2.0.1.zip

RUN unzip /tmp/rubyrep-2.0.1.zip -d /

WORKDIR /rubyrep-2.0.1

CMD ["/rubyrep-2.0.1/rubyrep", "--verbose", "scan", "-c", "/mnt/default.conf", "--summary"]
