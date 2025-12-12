#!/bin/bash -x

. .env

GIT_ROOT=`git rev-parse --show-toplevel`

pushd $GIT_ROOT

# https://github.com/containers/prometheus-podman-exporter/blob/main/install.md#container-image
# systemctl start --user podman.socket
podman run --name podman-exporter -d \
  --network sonarqube \
  -e CONTAINER_HOST=unix:///run/podman/podman.sock \
  -v $DOCKER_SOCKET:/run/podman/podman.sock \
  -p 9882:9882 \
  --userns=keep-id:uid=65534 \
  --security-opt label=disable \
  quay.io/navidys/prometheus-podman-exporter:latest

popd
