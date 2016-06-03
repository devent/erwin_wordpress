#!/bin/bash

if [ -d '/var/lib/mysql/lost+found' ]; then
    rm -rf '/var/lib/mysql/lost+found'
fi

mysql-docker-entrypoint.sh "$@"
