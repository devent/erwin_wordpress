FROM erwinnttdata/maradns-deadwood:latest

MAINTAINER Erwin Mueller "erwin.mueller@nttdata.com"

# remove maradns supervisord configuration
RUN set -x \
    && rm /etc/supervisor/conf.d/maradns.sv.conf

# replace deadwood configuration
ADD dwood3rc /etc/dwood3rc.custom
ADD dwood3rc /etc/dwood3rc

# expose dns port
EXPOSE 53/udp 53/tcp

# add entrypoint script
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

# run supervisord
CMD ["supervisord", "-c", "/etc/supervisor.conf"]
