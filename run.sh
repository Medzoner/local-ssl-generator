#!/usr/bin/env bash

DOCKER="docker-compose"
BUILDFLAGS="-f ./docker-compose.yml -p local-ssl-generator"

${DOCKER} ${BUILDFLAGS} rm -f
${DOCKER} ${BUILDFLAGS} pull

${DOCKER} ${BUILDFLAGS} build

${DOCKER} ${BUILDFLAGS} up -d --force-recreate

apt update
apt install -y --no-install-recommends libnss3-tools
apt install -y --no-install-recommends openssl
certutil -d sql:$HOME/.pki/nssdb -A -t "P,," -n "localhost" -i ./localhost.crt
certutil -L -d sql:${HOME}/.pki/nssdb