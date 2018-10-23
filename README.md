# docker-images

Public Docker images for Artsy applications

## Adding an image to Docker Hub

Adding an image to Docker Hub is a two-step process, first you build a new tag
and then you push it up, here's an example:

```
$ docker build -t artsy/ruby:2.5.3-node-chrome ruby/2.5.3-node-chrome/
$ docker push artsy/ruby:2.5.3-node-chrome
```

This new image will now be available to add to a Dockerfile like so:

```
FROM artsy/ruby:2.5.3-node-chrome
```
