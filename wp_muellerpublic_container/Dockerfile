FROM wordpress:4.5-fpm

MAINTAINER Erwin Mueller "erwin.mueller@nttdata.com"

VOLUME /var/www/html

# add entrypoint script
COPY docker-entrypoint.sh /usr/local/bin/
RUN set -x \
    && chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

# run nothing
CMD ["/bin/true"]
