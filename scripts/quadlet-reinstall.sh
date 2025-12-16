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

for i in quadlets/*; do
  BASE=$(basename $i)
  rm $TARGET_DIR/$BASE
  ln -f $i $TARGET_DIR/$BASE
done

popd

systemctl --user daemon-reload
