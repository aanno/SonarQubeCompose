#!/bin/bash -x
# prepares the community branch plugin container before first usage

. .env

GIT_ROOT=`git rev-parse --show-toplevel`
CB_VERSION=25.9.0.112764

pushd $GIT_ROOT

  chmod go+x scripts/cb-plugin-install.sh
  podman run --rm \
      --env-file .env \
      -v $PWD/jmx_prometheus_javaagent.jar:/opt/sonarqube/jmx_prometheus_javaagent.jar:z,ro \
      -v $PWD/jmx-prometheus-config.yml:/opt/sonarqube/jmx-prometheus-config.yml:z,ro \
      -v sonarqube_data:/opt/sonarqube/data \
      -v sonarqube_extensions:/opt/sonarqube/extensions \
      -v sonarqube_logs:/opt/sonarqube/logs \
      -v sonarqube_temp:/opt/sonarqube/temp \
      -v $PWD/export:/export:z \
      -v $PWD/scripts:/scripts:z,ro \
    docker.io/mc1arke/sonarqube-with-community-branch-plugin:$CB_VERSION-community \
    /scripts/cb-plugin-install.sh

popd
