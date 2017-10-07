#!/usr/bin/env bash

set -o errexit
#set -o nounset
set -o pipefail

# System-wide authentication for using Gitlab:
# The value of $CI_JOB_TOKEN is provided by a Gitlab CI runner. This token works only while the job is running.
echo -e "machine gitlab.com\nlogin ${GITLAB_LOGIN:-gitlab-ci-token}\npassword ${GITLAB_TOKEN:-$CI_JOB_TOKEN}" > ~/.netrc

$@
