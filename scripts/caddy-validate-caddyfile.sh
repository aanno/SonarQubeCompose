#!/bin/bash -x

# you need:
#
# * cargo install podlet
#   yq (https://github.com/mikefarah/yq/) version v4.50.1
# * for RHEL 9.4 yq is available: dnf install yp

set -euo pipefail

# export ALL that is needed in envsubst
# this is need for a interpolation directly in *.container files
export GIT_ROOT=`git rev-parse --show-toplevel`

pushd $GIT_ROOT

source .env
export ABUSE_EMAIL AUTO_HTTPS_SWITCH CADDY_HTTP_PORT CADDY_HTTPS_PORT SONAR_METRICS_HOST SUBDOMAIN

podman run --env-file .env -v $PWD/caddy:/etc/caddy:z --rm docker.io/library/caddy:2.10 caddy validate --config /etc/caddy/Caddyfile

popd
