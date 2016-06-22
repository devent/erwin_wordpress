#!/bin/bash
set -x

# if command starts with an option, prepend /bin/true
if [ "${1:0:1}" = '-' ]; then
    set -- /bin/true "$@"
fi

# Add local user;
# Either use the WORDPRESS_USER_ID if passed in at runtime or fallback.
#USER_ID=WORDPRESS_USER_ID:-9001}
#echo "Starting with UID : $USER_ID"
#usermod -u $USER_ID maradns

# update permissions
#chown -R maradns.maradns /etc/maradns
#chown -R maradns.maradns /var/cache/deadwood

# remove eventual lost+found directory from the data folder
if [ -d '/var/www/html/lost+found' ]; then
    rm -rf '/var/www/html/lost+found'
fi

# run command
exec "$@"
