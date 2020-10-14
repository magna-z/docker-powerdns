FROM alpine:3.11

ENV POWERDNS_VERSION=4.3.1

RUN set -ex \
    && apk --no-cache add \
      lua5.3-libs \
      libcurl \
      libgcc \
      libstdc++ \
      mariadb-connector-c \
      postgresql-libs \
    \
    && apk --no-cache add --virtual build-deps \
      boost-dev \
      curl-dev \
      g++ \
      lua5.3-dev \
      make \
      mariadb-dev \
      postgresql-dev \
      wget \
    \
    && wget -qO - https://downloads.powerdns.com/releases/pdns-$POWERDNS_VERSION.tar.bz2 | tar xjf - -C /tmp \
    && cd /tmp/pdns-$POWERDNS_VERSION \
    && ./configure --sysconfdir=/etc --with-modules="gmysql gpgsql" --with-dynmodules="" \
    && make install \
    \
    && apk del build-deps \
    && cd / && rm -rf /tmp/*

EXPOSE 53 53/udp 8081

ENTRYPOINT ["pdns_server", "--setuid=65534", "--setgid=65534", "--write-pid=no", "--disable-syslog=yes"]
