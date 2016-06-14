#!/bin/bash
set -eo pipefail

# if command starts with an option, prepend supervisord
if [ "${1:0:1}" = '-' ]; then
    set -- supervisord "$@"
fi

# Add local user;
# Either use the MARADNS_USER_ID if passed in at runtime or fallback.
USER_ID=${MARADNS_USER_ID:-9001}
echo "Starting with UID : $USER_ID"
usermod -u $USER_ID maradns

# update permissions
chown -R maradns.maradns /etc/maradns
chown -R maradns.maradns /var/cache/deadwood

# replace the UID and GID of the maradns user
MARADNS_UID=`id -u maradns`
MARADNS_GID=`id -g maradns`
cp /etc/mararc.custom /etc/mararc
sed -i -r "s/(maradns_uid\s*=\s*)([0-9]+)(.*)/\1${MARADNS_UID}\3/" /etc/mararc
sed -i -r "s/(maradns_gid\s*=\s*)([0-9]+)(.*)/\1${MARADNS_GID}\3/" /etc/mararc

# bind maradns on container host
MARADNS_ADDRESS=`ifconfig eth0 | grep 'inet addr:' | cut -d ' ' -f12 | cut -d ':' -f2`
sed -i -r "s/(ipv4_bind_addresses\s*=\s*)(.*)(.*)/\1\"${MARADNS_ADDRESS}\"\3/" /etc/mararc

# copy filebeat configuration
cp /etc/filebeat/filebeat.yml.custom /etc/filebeat/filebeat.yml

# run command
exec "$@"
