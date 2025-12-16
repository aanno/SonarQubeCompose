#!/bin/bash -x

# you need:
#
# * go install github.com/mikefarah/yq/v4@latest
#   from https://github.com/mikefarah/yq
#   podlet 0.3.0
# * cargo install podlet
#   yq (https://github.com/mikefarah/yq/) version v4.50.1

set -euo pipefail
. .env

GIT_ROOT=`git rev-parse --show-toplevel`
NAME=$(yq '.name' docker-compose.yml)
TARGET_DIR=~/.config/containers/systemd

pushd $GIT_ROOT

# ensure output directory
mkdir -p $TARGET_DIR | true

envsubst < $1 \
  | yq '(.volumes[] | select(has("external")) | .external) = false |
     (.networks[] | select(has("external")) | .external) = false' \
  | podlet -u -a --overwrite compose --pod - # > quadlets/

# -p 4.8 podman version 4.8: RHEL 9.4 has podman 4.9 but then --pod could NOT be given

for i in $TARGET_DIR/$NAME-* $TARGET_DIR/$NAME.*; do
  BASE=$(basename $i)
  ln -f $i quadlets/$BASE
done

popd

systemctl --user daemon-reload
