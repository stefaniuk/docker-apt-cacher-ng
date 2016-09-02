FROM stefaniuk/ubuntu:16.04-20160901
MAINTAINER daniel.stefaniuk@gmail.com
# SEE: https://docs.docker.com/engine/examples/apt-cacher-ng/

ARG APT_PROXY
ENV APT_CACHER_NG_VERSION="0.9.1"

RUN set -ex \
    \
    && if [ -n "$APT_PROXY" ]; then echo "Acquire::http { Proxy \"$APT_PROXY\"; };" >> /etc/apt/apt.conf.d/00proxy; fi \
    && apt-get --yes update \
    && apt-get --yes install apt-cacher-ng=${APT_CACHER_NG_VERSION}* \
    && rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/* /var/cache/apt/* \
    \
    && sed "s/^# ForeGround: 0/ForeGround: 1/" -i /etc/apt-cacher-ng/acng.conf \
    && sed "s/^# VerboseLog: 1/VerboseLog: 7/" -i /etc/apt-cacher-ng/acng.conf \
    && sed "s/^# Debug:3/Debug: 7/" -i /etc/apt-cacher-ng/acng.conf \
    && echo "http://httpredir.debian.org/debian/" > /etc/apt-cacher-ng/backends_debian \
    && echo "http://archive.ubuntu.com/ubuntu/" > /etc/apt-cacher-ng/backends_ubuntu \
    \
    && rm -f /etc/apt/apt.conf.d/00proxy

WORKDIR /var/cache/apt-cacher-ng
VOLUME [ "/var/cache/apt-cacher-ng" ]
EXPOSE 3142

COPY assets/sbin/bootstrap.sh /sbin/bootstrap.sh
CMD [ "apt-cacher-ng", "-c", "/etc/apt-cacher-ng" ]
