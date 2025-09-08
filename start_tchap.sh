#!/bin/bash

set -e

docker compose down

cp tchap/nginx/.app.local.dev.light.conf data-template/nginx/conf.d/app.conf
cp tchap/synapse/homeserver.local.dev.light.yaml data-template/synapse/homeserver.yaml
cp tchap/mas/config.local.dev.yaml data-template/mas/config.yaml


export COMPOSE_PROFILES="tchap,with_mas"
# Lancer les deux fichiers compose ensemble
#docker compose -f compose.yml -f compose-tchap-additional-services.yml up -d
docker compose -f compose.yml -f compose-tchap-additional-services.yml up -d
