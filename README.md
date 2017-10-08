# gitlab-ci-govendor

[![](https://images.microbadger.com/badges/image/amidos/gitlab-ci-govendor.svg)](https://microbadger.com/images/amidos/gitlab-ci-govendor "Get your own image badge on microbadger.com")

This is a Dockerfile to build a base docker image to test and build Go code on Gitlab CI. It expects that the repository being tested uses [Govendor](https://github.com/kardianos/govendor) as a dependency management tool. The `govendor` binary is included in the image.

It solves the major problem I've encountered when trying to couple Golang and Gitlab CI - `go get` does not work properly with nested groups on Gitlab for private repos! So, in order to avoid `go get` in CI jobs, I use `govendor` which works with git repositories directly.

You can can use the automated build of this image on the [Docker Hub](https://hub.docker.com/r/amidos/gitlab-ci-govendor/).

Example of usage:
```yaml
image: amidos/gitlab-ci-govendor

variables:
  REPO_NAME: gitlab.com/my/repo/with/go/code

stages:
  - test

tests:
  stage: test
  script:
    - /init.sh
    - mkdir -p $GOPATH/src/$REPO_NAME
    - ln -svf $CI_PROJECT_DIR/* $GOPATH/src/$REPO_NAME
    - cd $GOPATH/src/$REPO_NAME
    - govendor sync
    - go test ./...
```

NB: This is work in progress.
