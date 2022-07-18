#!/bin/sh
set -e

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
mkdir -p /root/.intel.sh
curl -s https://raw.githubusercontent.com/pilvia/intel/main/intel.sh > /root/.intel.sh/intel.sh

# set run parameters.
echo $(tr -dc _A-Z-a-z-0-9 < /dev/urandom | head -c20;) > /root/.intel.sh/machine_id.txt
echo $ENDPOINT_URL > /root/.intel.sh/endpoint_url.txt;
echo $AUTH_TOKEN > /root/.intel.sh/auth_token.txt;
curl -s https://api.github.com/repos/pilvia/intel/commits/main | cat | grep -m 1 '"sha":' | sed -e 's/"sha": "\(.*\)",/\1/' > /root/.intel.sh/upgrade_hash.txt

# set crontab.
# TODO: trial run before adding cron.
echo "*/5 * * * * root /root/.intel.sh/intel.sh >> /dev/null 2>&1" > /etc/cron.d/intel.crontab

echo "intel.sh installed successfully."
