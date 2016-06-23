FROM wordpress:4.5-fpm

MAINTAINER Erwin Mueller "erwin.mueller@nttdata.com"

# save parent's entrypoint script
RUN set -x \
    && mv /entrypoint.sh /wordpress-entrypoint.sh

# copy custom entrypoint script
COPY docker-entrypoint.sh /
RUN set -x \
    && chmod a-w /docker-entrypoint.sh \
    && chmod +x /docker-entrypoint.sh

# expose the wordpress installation
VOLUME /var/www/html

# set entrypoint script
ENTRYPOINT ["/docker-entrypoint.sh"]

# run php
CMD ["php-fpm"]
