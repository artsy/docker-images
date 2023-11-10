## Elasticsearch v6.8.23

Artsy custom Elasticsearch image is available for the following linux architectures: `amd64`, `arm64`

Download:

```
docker pull artsy/elasticsearch:6.8.23
```

Run:

```
docker run --rm -p 9200:9200 -p 9300:9300 -e http.cors.enabled=true -e http.cors.allow-origin='*' -e ES_JAVA_OPTS='-Xms512m -Xmx512m' artsy/elasticsearch:6.8.23
```

## Custom Elasticsearch v6.8.23 image(s)

The [official Elasticsearch docker repository](https://hub.docker.com/_/elasticsearch/tags?page=1&name=6.8.23) does not provide a `v6.8.23` image for `arm64` architecture. Running an `amd64` Elasticsearch `v6.8.23` image on Apple chip is not without issues and performance implications. To work around this absence and in order to make multi-arch images available the following _custom_ images are made available: [v6.8.23-amd64](https://hub.docker.com/r/artsy/elasticsearch/tags?page=1&name=6.8.23-amd64), [v6.8.23-arm64](https://hub.docker.com/r/artsy/elasticsearch/tags?page=1&name=6.8.23-arm64)

Included below are commands for building and pushing images:

> `docker login` is _required_ to access the artsy repository. credentials are located under "Docker" entry in 1password

> add `--platform linux/amd64` option to the `docker build` command when building `amd64` image on `arm64` hardware
```
# amd64 image build and push
cd amd64
docker build -t artsy/elasticsearch:6.8.23-amd64 .
docker push artsy/elasticsearch:6.8.23-amd64

# arm64 image build and push
cd arm64
docker build -t artsy/elasticsearch:6.8.23-arm64 .
docker push artsy/elasticsearch:6.8.23-arm64
```

## Multi-arch Elasticsearch image via docker manifest

> A manifest list is a list of image layers that is created by specifying one or more (ideally more than one) image names. It can then be used in the same way as an image name in `docker pull` and `docker run` commands

<sup>More details on docker manifest available in [docs](https://docs.docker.com/engine/reference/commandline/manifest/)</sup>

To create a manifest and make it available the underlying [images](#custom-elasticsearch-v6823-images) must be made available first. Once the images are available a manifest can be created like:

```
# create manifest
docker manifest create artsy/elasticsearch:6.8.23 artsy/elasticsearch:6.8.23-amd64 artsy/elasticsearch:6.8.23-arm64

# inspect manifest
docker manifest inspect --verbose artsy/elasticsearch:6.8.23

# push manifest
docker manifest push artsy/elasticsearch:6.8.23
```
