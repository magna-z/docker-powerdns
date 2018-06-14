FROM alpine:3.7

ENV POWERDNS_VERSION=4.1.3

RUN set -ex && \
    apk --no-cache add boost-dev mariadb-client-libs wget && \
    apk --no-cache add --virtual build-dependencies g++ make mariadb-dev && \
    wget -qO - https://downloads.powerdns.com/releases/pdns-$POWERDNS_VERSION.tar.bz2 | tar xjf - -C /tmp && \
    cd /tmp/pdns-$POWERDNS_VERSION && \
    ./configure --prefix="" --exec-prefix=/usr --sysconfdir=/etc/powerdns --with-modules="gmysql" --with-dynmodules="" && \
    make install && \
    apk del build-dependencies && \
    rm -rf /tmp/*

EXPOSE 53 53/udp 8081

ENTRYPOINT ["pdns_server"]

CMD ["--setuid=65534", "--setgid=65534", "--write-pid=no", "--disable-syslog=yes"]
