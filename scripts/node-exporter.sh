#!/bin/bash

# https://github.com/prometheus/node_exporter
# configuration: https://github.com/prometheus/exporter-toolkit/blob/master/docs/web-configuration.md
# Local containers see this at: http://host.docker.internal:9100/metrics
# You could see this at http://localhost:9100/metrics
# node-exporter:
#   image: quay.io/prometheus/node-exporter:latest
#   restart: unless-stopped
#   pid: "host"
#   network_mode: "host"
#   command:
#     - --path.rootfs=/host
#   volumes:
#     - /:/host:ro,rslave

set -euo pipefail
. .env

GIT_ROOT=`git rev-parse --show-toplevel`
NAME=node-exporter

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

podman run --name "$NAME" -d \
  -v /:/host:ro,rslave \
  --restart unless-stopped \
  --pid host \
  --network=host \
  quay.io/prometheus/node-exporter:latest \
  --path.rootfs=/host

popd
