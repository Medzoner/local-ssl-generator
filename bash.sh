#!/usr/bin/env bash

DOCKER="docker-compose -f ./docker-compose.yml -p local-ssl-generator"

#docker
${DOCKER} run local_ssl_generator
