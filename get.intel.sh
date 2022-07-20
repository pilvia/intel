#!/bin/sh
set -e

if [ -z "$HOME_DIR" ]; then
  HOME_DIR="/root/.intel.sh";
fi

# check for required parameters
if [ -z "$ENDPOINT_URL" ] || [ -z "$AUTH_TOKEN" ]; then
        echo "Missing ENDPOINT_URL or AUTH_TOKEN parameter.";
        exit 1;
fi

# check for required binaries
for i in curl cat grep sed tr; do
        if [ -z $(command -v "$i") ]; then
                echo "Missing binary $i.";
                exit 1;
        fi
done

# download the script.
mkdir -p $HOME_DIR
curl -s https://raw.githubusercontent.com/pilvia/intel/main/intel.sh > $HOME_DIR/intel.sh

# set run parameters.
tr -dc A-Z-a-z-0-9 < /dev/urandom | head -c20 > $HOME_DIR/machine_id.txt
echo $ENDPOINT_URL > $HOME_DIR/endpoint_url.txt;
echo $AUTH_TOKEN > $HOME_DIR/auth_token.txt;
curl -s https://api.github.com/repos/pilvia/intel/git/refs/heads/main | grep '"sha":' | sed -e 's/"sha": "\(.*\)",/\1/' > $HOME_DIR/upgrade_hash.txt
date +%s > $HOME_DIR/last_upgrade_check.txt

# set crontab.
# TODO: trial run before adding cron.
echo "*/5 * * * * root sh /root/.intel.sh/intel.sh >> /dev/null 2>&1" > /etc/cron.d/intel

echo "intel.sh installed successfully."
