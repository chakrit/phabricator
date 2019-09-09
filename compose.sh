#!/bin/sh

set +xe

DOCKER_BUILDKIT=1

docker-compose kill
docker-compose rm -f
docker-compose build
docker-compose up

