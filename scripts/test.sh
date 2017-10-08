#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail
set -o xtrace

# Test everything in the project except for the vendor directory
cd $GOPATH/src/$REPO_NAME
go test ./...
