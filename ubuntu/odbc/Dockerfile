FROM ubuntu:16.04

ENV TERM=xterm \
    DEBIAN_FRONTEND=noninteractive \
    UNIXODBC_VERSION=2.3.6 \
    POWERDNS_VERSION=4.1.3

RUN set -ex && \
    apt-get update && \
    apt-get install --yes --no-install-recommends \
        apt-transport-https \
        apt-utils \
        ca-certificates && \
    \
    apt-get upgrade --yes && \
    \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys BC528686B50D79E339D3721CEB3E94ADBE1229CF && \
    echo "deb [arch=amd64] https://packages.microsoft.com/ubuntu/16.04/prod xenial main" > /etc/apt/sources.list.d/mssql.list && \
    \
    apt-get update && \
    ACCEPT_EULA=Y apt-get install --yes --no-install-recommends \
        g++ \
        gcc \
        msodbcsql17 \
        libboost-all-dev \
        libc6-dev \
        libgss3 \
        libssl-dev \
        locales \
        make \
        wget && \
    \
    locale-gen --purge en_US.UTF-8 && update-locale LANG=en_US.UTF-8 && \
    \
    wget -qO - ftp://ftp.unixodbc.org/pub/unixODBC/unixODBC-$UNIXODBC_VERSION.tar.gz | tar xzf - -C /tmp && \
    cd /tmp/unixODBC-$UNIXODBC_VERSION && \
    CPPFLAGS=-DSIZEOF_LONG_INT=8 ./configure --enable-gui=no --enable-drivers=no --enable-iconv --with-iconv-char-enc=UTF8 --with-iconv-ucode-enc=UTF16LE --libdir=/usr/lib/x86_64-linux-gnu/ --prefix=/usr --sysconfdir=/etc && \
    make install && \
    \
    wget -qO - https://downloads.powerdns.com/releases/pdns-$POWERDNS_VERSION.tar.bz2 | tar xjf - -C /tmp && \
    cd /tmp/pdns-$POWERDNS_VERSION && \
    ./configure --prefix="" --exec-prefix=/usr --sysconfdir=/etc/powerdns --with-modules="godbc" --with-dynmodules="" && \
    make install && \
    \
    apt-get autoremove --yes g++ gcc wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/*

EXPOSE 53 53/udp 8081

ENTRYPOINT ["pdns_server"]

CMD ["--setuid=65534", "--setgid=65534", "--write-pid=no", "--disable-syslog=yes"]
