#!/bin/bash

# Support for stopping container with `Ctrl+C`
set -ex

# if command starts with an option, prepend run command
RUN_COMMAND=php-fpm
if [ "${1:0:1}" = '-' ]; then
    set -- $RUN_COMMAND "$@"
fi

# Add local user;
# Either use the 
# - WORDPRESS_USER_ID and
# - WORDPRESS_GROUP_ID
# if passed in at runtime or fallback.
USER_ID=${WORDPRESS_USER_ID:-9001}
GROUP_ID=${WORDPRESS_GROUP_ID:-9001}
echo "Starting with UID and GID: $USER_ID:$GROUP_ID"
usermod -u $USER_ID www-data
groupmod -g $GROUP_ID www-data

# remove eventual lost+found directory from the data folder
if [ -d '/var/www/html/lost+found' ]; then
    rm -rf '/var/www/html/lost+found'
fi

# update permissions
chown -R www-data.www-data /var/www/html

# secure directories and files
cd /var/www/html
# "root WordPress directory: all files should be writable only by your user account, except .htaccess if you want WordPress to automatically generate rewrite rules for you."
chown root.www-data ./*
chmod u=rwX,g=rX,o=rX ./*
# "WordPress administration area: all files should be writable only by your user account."
chown -R root.www-data ./wp-admin
chmod -R u=rwX,g=rX,o=rX ./wp-admin
# "The bulk of WordPress application logic: all files should be writable only by your user account."
chown -R root.www-data ./wp-includes
chmod -R u=rwX,g=rX,o=rX ./wp-includes
# "User-supplied content: intended to be writable by your user account and the web server process."
chown -R www-data.www-data ./wp-content
chmod -R u=rwX,g=rX,o=rX ./wp-content
# "Theme files. If you want to use the built-in theme editor, all files need to be writable by the web server process. If you do not want to use the built-in theme editor, all files can be writable only by your user account."
if [ $ALLOW_THEME_EDITOR ]; then
    chown -R www-data.www-data ./wp-content/themes
    chmod -R u=rwX,g=rX,o=rX ./wp-content/themes
else
    chown -R root.www-data ./wp-content/themes
    chmod -R u=rwX,g=rX,o=rX ./wp-content/themes
fi
# "Plugin files: all files should be writable only by your user account."
chown -R root.www-data ./wp-content/plugins
chmod -R u=rwX,g=rX,o=rX ./wp-content/plugins

# run parent's entrypoint script
/wordpress-entrypoint.sh "$@"
