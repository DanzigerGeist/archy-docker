#!/usr/bin/env bash

set -e

: "${ARCHY_HOME_DIR:=/opt/archy/archyHome}"
: "${ARCHY_REGION:=mypurecloud.com}"
: "${ARCHY_DEBUG:=false}"

if [[ -z "$ARCHY_AUTH_TOKEN" && ( -z "$ARCHY_CLIENT_ID" || -z "$ARCHY_CLIENT_SECRET" ) ]]; then
    echo "❌ ERROR: Either ARCHY_AUTH_TOKEN or (ARCHY_CLIENT_ID and ARCHY_CLIENT_SECRET) must be provided."
    exit 1
fi

cat <<EOF > /root/.archy_config
{
    "_beenConfigured": true,
    "homeDir": "${ARCHY_HOME_DIR}",
    "location": "${ARCHY_REGION}",
    "debug": "${ARCHY_DEBUG}",
    "clientId": "${ARCHY_CLIENT_ID}",
    "clientSecret": "${ARCHY_CLIENT_SECRET}",
    "authToken": "${ARCHY_AUTH_TOKEN}"
}
EOF

exec "$@"
