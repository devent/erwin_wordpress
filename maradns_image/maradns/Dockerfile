FROM erwinnttdata/maradns-deadwood:latest

MAINTAINER Erwin Mueller "erwin.mueller@nttdata.com"

# remove deadwood supervisord configuration
RUN set -x \
    && rm /etc/supervisor/conf.d/deadwood.sv.conf

# replace maradns configuration
ADD mararc /etc/mararc.custom
ADD mararc /etc/mararc

# expose dns port
EXPOSE 53

# add entrypoint script
COPY docker-entrypoint.sh /usr/local/bin/
RUN set -x \
    && chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

# run supervisord
CMD ["supervisord", "-c", "/etc/supervisor.conf"]
