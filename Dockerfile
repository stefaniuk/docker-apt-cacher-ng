FROM stefaniuk/ubuntu:16.04-20160829
MAINTAINER daniel.stefaniuk@gmail.com
# SEE: https://docs.docker.com/engine/examples/apt-cacher-ng/

ENV APT_CACHER_NG_VERSION="0.9.1" \
    APT_CACHER_NG_USER="apt-cacher-ng"

RUN set -ex \
    && apt-get --yes update \
    && apt-get --yes install apt-cacher-ng=${APT_CACHER_NG_VERSION}* \
    && rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/* /var/cache/apt/* \
    \
    && echo "ForeGround: 1" > /etc/apt-cacher-ng/apt-cacher-ng.conf \
    && echo 'http://httpredir.debian.org/debian/' > /etc/apt-cacher-ng/backends_debian \
    && echo 'http://archive.ubuntu.com/ubuntu/' > /etc/apt-cacher-ng/backends_ubuntu \
    && chown -R root:root /etc/apt-cacher-ng \
    && chmod 644 /etc/apt-cacher-ng/* \
    && chown -R $SYSTEM_USER:$SYSTEM_USER \
        /var/cache/apt-cacher-ng \
        /var/log/apt-cacher-ng

VOLUME [ "/var/cache/apt-cacher-ng" ]
EXPOSE 3142

CMD [ "apt-cacher-ng", "-c", "/etc/apt-cacher-ng" ]
