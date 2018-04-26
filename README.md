# docker-images

Public Docker images for Artsy applications

# Build Image
Build specific image by going to that image folder and run:
```shell
docker build -t artsy/<image name> .
```

If you would like to rebuild images in order of their dependencies, run `./bin/build.sh`


# Push to Docker hub
If it's a new image, you need to first create repository on [Docker Hub](https://hub.docker.com).

Once you created repository, build image and tag it properly and then push it to docker hub by:
```shell
docker push artsy/<the tag you just created>
```
