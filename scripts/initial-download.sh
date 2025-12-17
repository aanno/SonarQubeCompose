#!/bin/bash -x

. .env

GIT_ROOT=`git rev-parse --show-toplevel`
CB_VERSION=25.9.0

pushd $GIT_ROOT

# https://prometheus.github.io/jmx_exporter/1.5.0/java-agent/

  if [ ! -f jmx_exporter.jar ]; then
    curl -L -o jmx_prometheus_javaagent.jar https://github.com/prometheus/jmx_exporter/releases/download/1.5.0/jmx_prometheus_javaagent-1.5.0.jar
    curl -L -o sum.sha256 https://github.com/prometheus/jmx_exporter/releases/download/1.5.0/jmx_prometheus_javaagent-1.5.0.jar.sha256

    cat sum.sha256 | cut -d' ' -f 1 | tr -d $'\n' >jmx_prometheus_javaagent.jar.sha256
    echo " jmx_prometheus_javaagent.jar" >>jmx_prometheus_javaagent.jar.sha256
  fi
  if [ ! -f sonarqube-community-branch-plugin-$CB_VERSION.jar ]; then
    curl -L -o sonarqube-community-branch-plugin-$CB_VERSION.jar https://github.com/mc1arke/sonarqube-community-branch-plugin/releases/download/$CB_VERSION/sonarqube-community-branch-plugin-$CB_VERSION.jar
  fi
  cp sonarqube-community-branch-plugin-$CB_VERSION.jar export/ || true

popd

sha256sum -c jmx_prometheus_javaagent.jar.sha256
