#!/bin/bash

set -euo pipefail
. .env

GIT_ROOT=`git rev-parse --show-toplevel`
NAME=podman-exporter

pushd $GIT_ROOT

# Is a container with this name running?
if podman ps --format '{{.Names}}' | grep -qx "$NAME"; then
  # already running -> nothing to do
  echo "container $NAME is already running"
  exit 0
fi

# If it exists but is not running, remove it
if podman ps -a --format '{{.Names}}' | grep -qx "$NAME"; then
  podman rm "$NAME"
fi

# https://github.com/containers/prometheus-podman-exporter/blob/main/install.md#container-image
# systemctl start --user podman.socket
podman run --name "$NAME" -d \
  --restart unless-stopped \
  --network sonarqube \
  -e CONTAINER_HOST=unix:///run/podman/podman.sock \
  -v $DOCKER_SOCKET:/run/podman/podman.sock \
  -p 9882:9882 \
  --userns=keep-id:uid=65534 \
  --security-opt label=disable \
  quay.io/navidys/prometheus-podman-exporter:latest

popd
