FROM python:3.7-slim


ARG toolVersion=1.2.0

LABEL version="$toolVersion"
LABEL org.opencontainers.image.authors="Artsy"


RUN apt-get update && apt-get install -y \
  --no-install-recommends \
  build-essential \
  git \
  && rm -rf /var/lib/apt/lists/*

RUN pip install detect-secrets[word_list]==$toolVersion

WORKDIR /usr/src/app

ENTRYPOINT ["detect-secrets-hook", "--verbose"]
