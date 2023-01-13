
# Detect Secrets Artsy Docker Image

A custom docker image of [Yelp/detect-secrets](https://github.com/Yelp/detect-secrets)
<sup>*Used across select Artsy CI pipelines*</sup>

Dockerhub repo: [artsy/detect-secrets](https://hub.docker.com/r/artsy/detect-secrets)

## Build and Release using CI

To build and release a new version:

1. Modify the `Dockerfile` and change the version of `toolVersion` _ARG_ to the desired `detect-secrets` version (_likely the latest [released](https://github.com/Yelp/detect-secrets/releases) version_)
1. Push the change and open a PR
1. _Optional_: verify the build version
    <details>
      <summary>Explain</summary>

      Upon success _detect_secrets_build_ job will print out the tool version

      ```
      Successfully built b83d1aaea7ee
      Successfully tagged artsy/detect-secrets:20230113.174
      detect-secrets build matches specified tool version: 1.4.0
      ```

    </details>
1. Merging the PR to `main` will trigger the `detect-secrets-release` _workflow_ and the new image, tags will be pushed to dockerhub

## Build

When necessary to build manually (_outside CI_) use the `build` script

`./build [version]`

## Push

To push image to dockerhub use the `push` script

`./push [version]`
