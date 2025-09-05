#!/bin/bash

set -e

docker compose down

cp tchap/nginx/.app.local.dev.light.conf data-template/nginx/conf.d/app.conf
cp tchap/synapse/homeserver.local.dev.light.yaml data-template/synapse/homeserver.yaml

# Lancer les deux fichiers compose ensemble
docker compose -f compose-tchap-light.yml -f compose-tchap-additional-services.yml up -d
