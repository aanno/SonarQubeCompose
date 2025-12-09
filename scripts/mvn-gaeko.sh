#!/bin/bash -x

. .env

pushd $GAEKO_PATH

mvn clean verify sonar:sonar \
  -Dsonar.projectKey=gaeko \
  -Dsonar.projectName='gaeko' \
  -Dsonar.host.url=$SONAR_URL \
  -Dsonar.token=$SONAR_GAEKO_TOKEN

popd
