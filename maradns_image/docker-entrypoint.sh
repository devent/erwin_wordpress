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
# replace the UID and GID of the maradns user
cp /etc/dwood3rc.custom /etc/dwood3rc
sed -i -r "s/(maradns_uid\s*=\s*)([0-9]+)(.*)/\1${MARADNS_UID}\3/" /etc/dwood3rc
sed -i -r "s/(maradns_gid\s*=\s*)([0-9]+)(.*)/\1${MARADNS_GID}\3/" /etc/dwood3rc

# run supervisord
exec supervisord -c /etc/supervisor.conf
