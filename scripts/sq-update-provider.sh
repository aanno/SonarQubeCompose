#!/bin/bash -x

#TARGET=ex.thomas.pasch@accso.de
#PW=<admin_password>
TARGET=$1

curl -v -v -v -u admin:$PW \
  https://sonarqube.qs-node2.gaeko.f7.accso.dev/api/users/update_identity_provider \
  -d "login=$TARGET" \
  -d "newExternalProvider=saml" \
  -d "newExternalIdentity=$TARGET"

