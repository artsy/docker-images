FROM --platform=linux/amd64 python:3.10-slim


ARG toolVersion=1.5.0
ARG artsyVersion=1

LABEL version="$toolVersion-$artsyVersion"
LABEL org.opencontainers.image.authors="Artsy"

ENV PIP_ROOT_USER_ACTION=ignore

RUN apt-get update && apt-get install -y \
  --no-install-recommends \
  build-essential \
  git \
  openssh-client \
  && rm -rf /var/lib/apt/lists/*

RUN pip install detect-secrets[word_list]==$toolVersion

WORKDIR /usr/src/app

ENTRYPOINT ["detect-secrets-hook", "--verbose"]
