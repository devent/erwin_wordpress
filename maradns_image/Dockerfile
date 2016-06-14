FROM debian:jessie

MAINTAINER Erwin Mueller "erwin.mueller@nttdata.com"

ENV MARADNS_VERSION 2.0.13
ENV DEADWOOD_VERSION 3.2.09

# maradns user
RUN set -x \
    && useradd -rU maradns

# optional add proxy entries for apt
RUN set -x \
    && [ -n \"${http_proxy}\" ] && echo Acquire::http::Proxy \"$http_proxy\"; >> /etc/apt/apt.conf.d/08proxy && true \
    && [ -n \"${ftp_proxy}\" ] && echo Acquire::ftp::Proxy \"$ftp_proxy\"; >> /etc/apt/apt.conf.d/08proxy && true

# add tools
RUN set -x \
    && apt-get update \
    && apt-get install -y dnsutils net-tools bsdmainutils sed \
    && rm -rf /var/lib/apt/lists/*

# supervisor installation
RUN set -x \
    && apt-get update \
    && apt-get install -y supervisor \
    && mkdir -p /var/log/supervisor \
    && mkdir -p /etc/supervisor/conf.d \
    && rm -rf /var/lib/apt/lists/*

# directories
RUN set -x \
    && mkdir -p /usr/local/bin \
    && mkdir -p /usr/local/share/man/man1 \
    && mkdir -p /usr/local/share/man/man5 \
    && mkdir -p /usr/local/share/man/man8

# install maradns
RUN set -x \
    && apt-get update \
    && apt-get install -y \
                        curl \
                        wget \
                        gnupg \
                        build-essential \
                        bzip2 \
    && cd /tmp \
    && curl -sSL http://maradns.samiam.org/gpgkey.txt | gpg --import - \
    && wget http://maradns.samiam.org/download/2.0/$MARADNS_VERSION/maradns-${MARADNS_VERSION}.tar.bz2 \
    && wget http://maradns.samiam.org/download/2.0/${MARADNS_VERSION}/maradns-${MARADNS_VERSION}.tar.bz2.asc \
    && gpg --verify maradns-${MARADNS_VERSION}.tar.bz2.asc \
    && tar xjf maradns-${MARADNS_VERSION}.tar.bz2 \
    && cd /tmp/maradns-${MARADNS_VERSION} \
    && ./configure && make \
    && make install \
    && rm -rf /tmp/maradns-${MARADNS_VERSION} \
    && rm /tmp/maradns-${MARADNS_VERSION}.tar.bz2.asc \
    && rm /tmp/maradns-${MARADNS_VERSION}.tar.bz2 \
    && apt-get remove --auto-remove -y build-essential \
    && rm -rf /var/lib/apt/lists/*
    
# install deadwood
RUN set -x \
    && apt-get update \
    && apt-get install -y \
                        curl \
                        wget \
                        gnupg \
                        build-essential \
                        bzip2 \
    && cd /tmp \
    && curl -sSL http://maradns.samiam.org/gpgkey.txt | gpg --import - \
    && wget http://maradns.samiam.org/deadwood/stable/deadwood-${DEADWOOD_VERSION}.tar.bz2 \
    && wget http://maradns.samiam.org/deadwood/stable/deadwood-${DEADWOOD_VERSION}.tar.bz2.asc \
    && gpg --verify deadwood-${DEADWOOD_VERSION}.tar.bz2.asc \
    && tar xjf deadwood-${DEADWOOD_VERSION}.tar.bz2 \
    && cd /tmp/deadwood-${DEADWOOD_VERSION}/src \
    && make \
    && cd /tmp/deadwood-${DEADWOOD_VERSION} \
    && cp src/Deadwood /usr/local/bin \
    && cp doc/Deadwood.1 /usr/local/share/man/man1 \
    && cd \
    && rm -rf /tmp/deadwood-${DEADWOOD_VERSION} \
    && rm /tmp/deadwood-${DEADWOOD_VERSION}.tar.bz2.asc \
    && rm /tmp/deadwood-${DEADWOOD_VERSION}.tar.bz2 \
    && apt-get remove --auto-remove -y build-essential \
    && rm -rf /var/lib/apt/lists/*

# deadwood cache directory
RUN set -x \
    && mkdir -p /var/cache/deadwood \
    && chown maradns.maradns /var/cache/deadwood

# supervisor base configuration
ADD supervisor.conf /etc/supervisor.conf

# supervisor maradns configuration
ADD maradns.sv.conf /etc/supervisor/conf.d/
ADD deadwood.sv.conf /etc/supervisor/conf.d/

# maradns configuration
ADD mararc /etc/mararc.custom
ADD mararc /etc/mararc

# deadwood configuration
ADD dwood3rc /etc/dwood3rc.custom
ADD dwood3rc /etc/dwood3rc

# maradns chroot directory
VOLUME /etc/maradns

# deadwood cache directory
VOLUME /var/cache/deadwood

# expose dns
EXPOSE 53/udp 53/tcp

# use filebeat to log maradns
# install filebeat
RUN set -x \
    && apt-get update \
    && apt-get install -y \
                        curl apt-transport-https ca-certificates \
    && curl https://packages.elasticsearch.org/GPG-KEY-elasticsearch | apt-key add - \
    && echo "deb https://packages.elastic.co/beats/apt stable main" > /etc/apt/sources.list.d/beats.list \
    && apt-get update && apt-get install filebeat \
    && apt-get remove --auto-remove -y curl \
    && rm -rf /var/lib/apt/lists/*

# add filebeat supervisord configuration
ADD filebeat.sv.conf /etc/supervisor/conf.d/

# add filebeat configuration
ADD filebeat.yml /etc/filebeat/filebeat.yml.custom
ADD filebeat.yml /etc/filebeat/filebeat.yml

# add entrypoint script
COPY docker-entrypoint.sh /usr/local/bin/
RUN set -x \
    && chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

# run supervisord
CMD ["supervisord", "-c", "/etc/supervisor.conf"]
