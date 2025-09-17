#!/bin/bash

set -e

#remove all services
docker compose --profile "*" down


cp tchap/synapse/homeserver.local.dev.light.yaml data-template/synapse/homeserver.yaml
cp tchap/mas/config.local.dev.yaml data-template/mas/config.yaml
cp tchap/tchap-web/config.local.json data-template/tchap-web/config.local.json

# start docker compose with main services and tchap services
docker compose -f compose.yml -f compose-tchap-additional-services.yml up -d
