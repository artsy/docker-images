FROM docker.io/runatlantis/atlantis:v0.16.0

RUN apk update && apk add \
  jq \
  openssl \
  python3 \
  py3-pip

RUN pip install awscli

RUN curl -L https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/v0.4.0/aws-iam-authenticator_0.4.0_linux_amd64 -o /usr/local/bin/aws-iam-authenticator && chmod a+x /usr/local/bin/aws-iam-authenticator

RUN curl -L https://storage.googleapis.com/kubernetes-release/release/v1.18.0/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl && chmod a+x /usr/local/bin/kubectl
