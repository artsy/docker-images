# This Dockerfile is used to build the image for execution in AWS Batch jobs.
FROM postgres:12

RUN apt-get update -qq && apt-get install -y curl unzip mandoc && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install
RUN rm -rf awscliv2.zip aws

ADD export-db.sh .
ADD import-db.sh .

CMD ["sh", "./export-db.sh", "latest"]
