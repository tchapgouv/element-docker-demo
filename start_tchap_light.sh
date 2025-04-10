#!/bin/bash

set -e

cp tchap/nginx/.app.local.dev.light.conf data-template/nginx/conf.d/app.conf
cp tchap/synapse/homeserver.local.dev.light.yaml data-template/synapse/homeserver.yaml

docker compose -f compose-tchap-light.yml up