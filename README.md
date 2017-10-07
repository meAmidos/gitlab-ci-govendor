# gitlab-ci-govendor
This is a Dockerfile to build a base docker image to test and build Go code on Gitlab CI. It expects that the repository being tested uses [Govendor](https://github.com/kardianos/govendor) as a dependency management tool. The `govendor` binary is included in the image.

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
