#!/bin/sh
set -e

HOME_DIR="/root/.intel.sh";

# Check for an upgrade
NEW_HASH=$(curl -s https://api.github.com/repos/pilvia/intel/git/refs/heads/main | grep '"sha":' | sed -e 's/"sha": "\(.*\)",/\1/')
OLD_HASH=$(cat $HOME_DIR/upgrade_hash.txt);
if [ ! "$NEW_HASH" = "$OLD_HASH" ]; then
    curl -s https://raw.githubusercontent.com/pilvia/intel/main/intel.sh > $HOME_DIR/intel.sh
fi

# Server status information.
MACHINE_ID=$(cat $HOME_DIR/machine_id.txt);
PUBLIC_IP=$(curl -s ifconfig.co);
HOSTNAME=$(hostname);
DATE=$(date);
EXTRA="nothing";

# Endpoint variables.
AUTH_TOKEN=$(cat $HOME_DIR/auth_token.txt);
ENDPOINT_ADDRESS=$(cat $HOME_DIR/endpoint_url.txt);

# Update server status
curl -X POST -H "Content-Type: application/json" -H "Authorization: $AUTH_TOKEN" $ENDPOINT_ADDRESS -d '{
  "id":"'"$MACHINE_ID"'",
  "publicIp":"'"$PUBLIC_IP"'",
  "hostName":"'"$HOSTNAME"'",
  "date":"'"$DATE"'",
  "extra":"'"$EXTRA"'"
}'
