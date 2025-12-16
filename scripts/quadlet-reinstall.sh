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
systemctl --user stop sonarqube-pod.service || true

systemctl --user reset-failed sonarqube-caddy.service || true
systemctl --user reset-failed sonarqube-grafana.service || true
# systemctl --user reset-failed sonarqube-network.service || true
systemctl --user reset-failed sonarqube-pg_sonar_exporter.service || true
systemctl --user reset-failed sonarqube-pg_sonar.service || true
systemctl --user reset-failed sonarqube-pod.service || true
systemctl --user reset-failed sonarqube-prometheus.service || true
systemctl --user reset-failed sonarqube-sonarqube.service || true

for i in quadlets/*; do
  BASE=$(basename $i)
  rm $TARGET_DIR/$BASE
  ln -f $i $TARGET_DIR/$BASE
done

popd

systemctl --user daemon-reload
# sleep 1
# systemctl --user start sonarqube-pod.service
# sleep 2
# systemctl --user status sonarqube-pod.service
