#!/bin/bash -x

. .env

pushd $GAEKO_UI_PATH

# next line is needed only once
pnpm install @sonar/scan

$JS_SONAR_PREFIX/sonar \
  -Dsonar.host.url=$SONAR_URL \
  -Dsonar.token=$SONAR_GAEKO_UI_TOKEN \
  -Dsonar.projectKey=gaeko-ui \
  -Dprevious.version=0.2.1

popd
