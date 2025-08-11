# docker-images

Public Docker images for Artsy applications

> CI has been configured to use [dynamic configuration](https://circleci.com/docs/using-dynamic-configuration/) and [circleci/path-filtering orb](https://circleci.com/developer/orbs/orb/circleci/path-filtering).

## Adding an image to Docker Hub

Adding an image to Docker Hub is a two-step process: first you build a new tag and then you push it up. You may need to add yourself to the Artsy organization in Docker Hub, or use `docker login` with credentials listed under "Docker" in 1password.

Here's an example:

```
$ docker build -t artsy/ruby:2.5.3-node-chrome ruby/2.5.3-node-chrome/ --platform linux/amd64
$ docker push artsy/ruby:2.5.3-node-chrome
```

This image will then be available to add to a Dockerfile like so:

```
FROM artsy/ruby:2.5.3-node-chrome
```
