FROM debian:jessie

MAINTAINER Erwin Mueller "erwin.mueller@nttdata.com"

ENV MARADNS_VERSION 2.0.13
ENV DEADWOOD_VERSION 3.2.09

RUN set -x \
    && [ -n \"${http_proxy}\" ] && echo Acquire::http::Proxy \"$http_proxy\"; >> /etc/apt/apt.conf.d/08proxy && true \
    && [ -n \"${ftp_proxy}\" ] && echo Acquire::ftp::Proxy \"$ftp_proxy\"; >> /etc/apt/apt.conf.d/08proxy && true

RUN set -x \
    && apt-get update \
    && apt-get install -y dnsutils net-tools \
    && rm -rf /var/lib/apt/lists/*

# supervisor installation
# create directory for child images to store configuration in
RUN set -x \
    && apt-get update \
    && apt-get install -y supervisor \
    && mkdir -p /var/log/supervisor \
    && mkdir -p /etc/supervisor/conf.d \
    && rm -rf /var/lib/apt/lists/*

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
    && useradd -rU maradns \
    && tar xjf maradns-${MARADNS_VERSION}.tar.bz2 \
    && cd /tmp/maradns-${MARADNS_VERSION} \
    && ./configure && make \
    && mkdir -p /usr/local/share/man/man1 \
    && mkdir -p /usr/local/share/man/man5 \
    && mkdir -p /usr/local/share/man/man8 \
    && make install \
    && rm -rf /tmp/maradns-${MARADNS_VERSION} \
    && rm /tmp/maradns-${MARADNS_VERSION}.tar.bz2.asc \
    && rm /tmp/maradns-${MARADNS_VERSION}.tar.bz2 \
    && apt-get remove --auto-remove -y build-essential \
    && rm -rf /var/lib/apt/lists/*
    
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
    && mkdir -p /usr/local/bin \
    && mkdir -p /usr/local/share/man/man1 \
    && cp src/Deadwood /usr/local/bin \
    && cp doc/Deadwood.1 /usr/local/share/man/man1 \
    && cd \
    && rm -rf /tmp/deadwood-${DEADWOOD_VERSION} \
    && rm /tmp/deadwood-${DEADWOOD_VERSION}.tar.bz2.asc \
    && rm /tmp/deadwood-${DEADWOOD_VERSION}.tar.bz2 \
    && apt-get remove --auto-remove -y build-essential \
    && rm -rf /var/lib/apt/lists/*

RUN set -x \
    && mkdir -p /var/cache/deadwood \
    && chown maradns.maradns /var/cache/deadwood

# supervisor base configuration
ADD supervisor.conf /etc/supervisor.conf

# supervisor maradns configuration
ADD maradns.sv.conf /etc/supervisor/conf.d/
ADD deadwood.sv.conf /etc/supervisor/conf.d/

ADD mararc /etc/mararc

ADD dwood3rc /etc/dwood3rc

VOLUME /etc/maradns
VOLUME /var/cache/deadwood

EXPOSE 53

CMD ["supervisord", "-c", "/etc/supervisor.conf"]
