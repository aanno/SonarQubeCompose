#!/bin/bash -x

set -euo pipefail
. .env

GIT_ROOT=`git rev-parse --show-toplevel`
NAME=podman-exporter

pushd $GIT_ROOT

envsubst < $1 | podlet compose --pod - # > quadlets/

popd
