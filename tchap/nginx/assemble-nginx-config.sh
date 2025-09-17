#!/bin/bash

# Script to assemble nginx configuration based on active Docker Compose profiles
# This script is executed during the templating process in init.sh

# Function to check if a profile is active
has_profile() {
    echo "$COMPOSE_PROFILES" | grep -q "$1"
}

# check that COMPOSE_PROFILES is correct, it must contains at least one of  with_tchap_mas or with_element_mas
# one of with_element_web or with_tchap_web
# tchap and element are not mandatory

# Verify required profiles
if ! (has_profile "with_tchap_mas" || has_profile "with_element_mas"); then
    echo "ERROR: COMPOSE_PROFILES must contain at least one of 'with_tchap_mas' or 'with_element_mas'"
    exit 1
fi

if ! (has_profile "with_element_web" || has_profile "with_tchap_web"); then
    echo "ERROR: COMPOSE_PROFILES must contain at least one of 'with_element_web' or 'with_tchap_web'"
    exit 1
fi

echo "COMPOSE_PROFILES validation successful: $COMPOSE_PROFILES"


export MAS_SERVICE="http://host.docker.internal:8080"
# Update service variables based on active profiles
if has_profile "with_tchap_mas"; then
    echo "Using mas-tchap service"
    export MAS_SERVICE="http://host.docker.internal:8080"
fi

export APP_WEB_SERVICE="http://element-web"
if has_profile "with_tchap_web"; then
    echo "Using tchap-web service"
    export APP_WEB_SERVICE="http://tchap-web"
fi

# Start with the base configuration
echo "Using base configuration"
cp /tchap/nginx/full-profiles/base.conf.template /data/nginx/conf.d/app.conf.tmp

# Process identity server placeholder
IDENTITY_SERVER_CONFIG=""
if has_profile "tchap"; then
    echo "Including tchap identity server configuration with env replacement"
    export IDENTITY_SERVER_CONFIG=$(envsubst < /tchap/nginx/full-profiles/tchap.conf.template)

    # Also include keycloak configuration
    echo "Including keycloak configuration"
    cat /tchap/nginx/full-profiles/keycloak.conf.template >> /data/nginx/conf.d/app.conf.tmp
fi

WORKERS_CONFIG=""
if has_profile "with_workers"; then
    echo "Including workers config configuration"
    export WORKERS_CONFIG=$(envsubst <  /tchap/nginx/full-profiles/workers.conf.template)
fi

# Replace the placeholder with the identity server configuration
#sed -i.bak "s|\${PLACEHOLDER_FOR_IDENTITY_SERVER}|${IDENTITY_SERVER_CONFIG}|g" /data/nginx/conf.d/app.conf.tmp


# Add element_call configuration if profile is active
if has_profile "with_element_call"; then
    echo "Including element_call configuration"
    cat /tchap/nginx/full-profiles/element_call.conf.template >> /data/nginx/conf.d/app.conf.tmp
fi

# Replace environment variables
echo "Replacing environment variables"
envsubst < /data/nginx/conf.d/app.conf.tmp > /data/nginx/conf.d/app.conf
rm /data/nginx/conf.d/app.conf.tmp /data/nginx/conf.d/app.conf.tmp.bak

echo "Nginx configuration assembled successfully based on profiles: $COMPOSE_PROFILES"
