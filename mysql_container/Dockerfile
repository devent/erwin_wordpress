FROM mysql:5.7

MAINTAINER Erwin Mueller "erwin.mueller@nttdata.com"

COPY my.cnf /etc/mysql/my.cnf
RUN set -x \
    && chmod a-wx /etc/mysql/my.cnf

RUN set -x \
    && mv /usr/local/bin/docker-entrypoint.sh /usr/local/bin/mysql-docker-entrypoint.sh

COPY docker-entrypoint.sh /usr/local/bin/
RUN set -x \
    && chmod a-w /usr/local/bin/docker-entrypoint.sh \
    && chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 3306
CMD ["mysqld"]
