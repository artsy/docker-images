
# Detect Secrets Artsy Docker Image

A custom docker image of [Yelp/detect-secrets](https://github.com/Yelp/detect-secrets)
<sup>*Used across select Artsy CI pipelines*</sup>

Dockerhub repo: [artsy/detect-secrets](https://hub.docker.com/r/artsy/detect-secrets)

## Upgrade and Release

To build and release a new version using CI:

1. Cut a new branch and include '`detect-secrets`' in the branch name (_required_ to trigger the workflow run)
1. Modify the `Dockerfile` and change the version of `toolVersion` _ARG_ to the desired `detect-secrets` version (_likely the latest [released](https://github.com/Yelp/detect-secrets/releases) version_)
1. Push the change and open a PR
1. _Optional_: verify the build version
    <details>
      <summary>Explain</summary>

      Upon success _detect_secrets_build_ job will print out the built tool version

      ![version check](https://drive.google.com/uc?id=1kmPPgW6emB3xg7TUbyubTC-Tmvopb1aM)

    </details>
1. Once the PR is approved, approve the _workflow hold_ to release the new version
    <details>
      <summary>Explain</summary>

    ![approve hold](https://drive.google.com/uc?id=1BNMYP71hWlrUfXd3vZ6nuuFxalkEsN2U)

    - When the change is pushed to github, a new image is built and the workflow is put on _hold_. This is done to allow for a _more_ controlled release and to prevent the image from getting pushed upstream until the PR is _reviewed and approved_
    - Once the _workflow hold_ is approved the new image is pushed to dockerhub (including all associated tags)
      - Any project using this image (`ci` tag specifically) will start using the new version

    </details>
1. Merge the PR (once all steps :green_circle:)

## Build

When necessary to build manually (_outside CI_) use the `build` script

`./build [version]`

## Push

To push image to dockerhub use the `push` script

`./push [version]`
