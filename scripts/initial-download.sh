#!/bin/bash -x

. .env

GIT_ROOT=`git rev-parse --show-toplevel`

pushd $GIT_ROOT

# https://prometheus.github.io/jmx_exporter/1.5.0/java-agent/

  if [ ! -f jmx_exporter.jar ]; then
    curl -o jmx_prometheus_javaagent.jar https://github.com/prometheus/jmx_exporter/releases/download/1.5.0/jmx_prometheus_javaagent-1.5.0.jar
    curl -o jmx_prometheus_javaagent.jar.sha256 https://github.com/prometheus/jmx_exporter/releases/download/1.5.0/jmx_prometheus_javaagent-1.5.0.jar.sha256

    cat jmx_prometheus_javaagent.jar.sha256 | cut -d' ' -f 1 | tr -d $'\n' >jmx_prometheus_javaagent.jar.sha256
    echo " jmx_exporter.jar" >>jmx_prometheus_javaagent.jar.sha256
  fi


popd

sha256sum -c jmx_prometheus_javaagent.jar.sha256
