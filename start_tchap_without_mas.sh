#!/bin/bash

set -e

cp tchap/nginx/.app.local.dev.without.mas.conf data-template/nginx/conf.d/app.conf
cp tchap/synapse/homeserver.local.dev.without.mas.yaml data-template/synapse/homeserver.yaml

docker compose -f compose-tchap.yml up