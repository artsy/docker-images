FROM artsy/alpine-scala

RUN apk add --no-cache --virtual=.build-dependencies git openssh-client
RUN mkdir ~/.ssh && ssh-keyscan -H github.com >> ~/.ssh/known_hosts

CMD ["/bin/bash"]
