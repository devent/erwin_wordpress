FROM erwinnttdata/maradns-deadwood:latest

MAINTAINER Erwin Mueller "erwin.mueller@nttdata.com"

RUN set -x \
    && rm /etc/supervisor/conf.d/deadwood.sv.conf

ADD mararc /etc/mararc

EXPOSE 53

CMD ["supervisord", "-c", "/etc/supervisor.conf"]
