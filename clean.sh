#!/bin/bash

docker compose down

rm -r data/
rm -r secrets/
rm -r tmp/
rm .env