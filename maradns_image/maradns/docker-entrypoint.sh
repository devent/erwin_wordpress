#!/bin/bash

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
HOST_NAME=`hostname -f`
HOST_ADDRESS=`grep $HOST_NAME /etc/hosts|cut -d " " -f1`
sed -i -r "s/(ipv4_bind_addresses\s*=\s*)(.*)(.*)/\1\"${HOST_ADDRESS}\"\3/" /etc/mararc

# copy filebeat configuration
cp /etc/filebeat/filebeat.yml.custom /etc/filebeat/filebeat.yml

# run supervisord
exec supervisord -c /etc/supervisor.conf
