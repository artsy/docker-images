# JDK8 images with Amazon's Corretto

This image is based on Amazon's [Corretto](https://docs.aws.amazon.com/corretto/latest/corretto-8-ug/what-is-corretto-8.html) version of the JDK.

There are Dockerfiles for JDK and JRE. The images are built and pushed to Docker Hub using the `build.sh` script in this directory.

## Usage Example

```Dockerfile
FROM artsy/openjdk:corretto8
```

```Dockerfile
FROM artsy/openjdk:corretto8-jre
```
