# SBT/Corretto image

This image is based on [Amazon Corretto](https://hub.docker.com/_/amazoncorretto),
and contains [Scala](http://www.scala-lang.org/) and [sbt](https://www.scala-sbt.org/).

Build and deploy to Docker Hub using `./build.sh`.

## Usage Example

```Dockerfile
FROM artsy/scala:2.12
```

For running using  [hokusai](https://github.com/artsy/hokusai) or CircleCI

```Dockerfile
FROM artsy/scala:2.12-node
```
