#!/bin/bash -x

# installs the community branch plugin into the container/volumen
# to use inside the docker.io/mc1arke/sonarqube-with-community-branch-plugin container

mkdir -p /opt/sonarqube/extensions/plugins/
cp /export/sonarqube-community-branch-plugin-*.jar /opt/sonarqube/extensions/plugins/
