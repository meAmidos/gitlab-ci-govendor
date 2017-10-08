#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
set -o xtrace

# Copy files from the workpspace to the GOPATH
# REPO_NAME variable should be set in the .gitlab-ci.yml file.
mkdir -p $GOPATH/src/$REPO_NAME
cp -R $CI_PROJECT_DIR/* $GOPATH/src/$REPO_NAME
cd $GOPATH/src/$REPO_NAME

# Check existing dependencies in the vendor directory
# that might have been populated from the cache
# and then download everything that is missed.
govendor sync

# Copy the updated vendor packages back to the workspace
# so that they could be cached if caching is enabled
# in .gitlab-ci.yml.
cp -R $GOPATH/src/$REPO_NAME/vendor $CI_PROJECT_DIR
