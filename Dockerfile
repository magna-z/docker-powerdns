FROM alpine:3.4

MAINTAINER Maxim Zalysin <zalysin.m@gmail.com>

LABEL pro.magnaz.docker.powerdns.version="{\"container\": 1.0, \"alpine\": 3.4, \"powerdns\": 4.0.1}"

RUN export PDNS_VERSION=4.0.1 && \
    apk --no-cache add --virtual .build-deps \
    g++ \
    gcc \
    libc-dev \
    boost-dev \
    openssl-dev \
    make \
    curl && \
    curl -sS https://downloads.powerdns.com/releases/pdns-$PDNS_VERSION.tar.bz2 | tar xjf - -C /tmp && \
    cd /tmp/pdns-$PDNS_VERSION && ./configure --with-modules="remote" && make && make install && \
    cd / && rm -rf /tmp/pdns-$PDNS_VERSION

EXPOSE 53 53/udp

ENTRYPOINT ["/usr/local/sbin/pdns_server"]