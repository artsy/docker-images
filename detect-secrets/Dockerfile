FROM python:3.10-slim


ARG toolVersion=1.3.0
ARG ourVersion=1

LABEL version="$toolVersion-$ourVersion"
LABEL org.opencontainers.image.authors="Artsy"


RUN apt-get update && apt-get install -y \
  --no-install-recommends \
  build-essential \
  git \
  openssh-client \
  && rm -rf /var/lib/apt/lists/*

RUN pip install detect-secrets[word_list]==$toolVersion

WORKDIR /usr/src/app

ENTRYPOINT ["detect-secrets-hook", "--verbose"]
