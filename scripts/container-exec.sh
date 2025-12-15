#!/bin/bash -x

. .env

GIT_ROOT=`git rev-parse --show-toplevel`

pushd $GIT_ROOT

podman exec -it sonarqubecompose_sonarqube_1 bash

popd
