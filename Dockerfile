FROM codeworksio/ubuntu:18.04-20180210

# SEE: https://docs.docker.com/engine/examples/apt-cacher-ng/

ARG APT_PROXY
ARG APT_PROXY_SSL
ENV APT_CACHER_NG_VERSION="3.1"

RUN set -ex; \
    \
    if [ -n "$APT_PROXY" ]; then echo "Acquire::http { Proxy \"http://${APT_PROXY}\"; };" > /etc/apt/apt.conf.d/00proxy; fi; \
    if [ -n "$APT_PROXY_SSL" ]; then echo "Acquire::https { Proxy \"https://${APT_PROXY_SSL}\"; };" > /etc/apt/apt.conf.d/00proxy; fi; \
    apt-get --yes update; \
    apt-get --yes install \
        apt-cacher-ng=${APT_CACHER_NG_VERSION}* \
    ; \
    sed "s/^# ForeGround: 0/ForeGround: 1/" -i /etc/apt-cacher-ng/acng.conf; \
    sed "s/^# VerboseLog: 1/VerboseLog: 7/" -i /etc/apt-cacher-ng/acng.conf; \
    sed "s/^# Debug:3/Debug: 7/" -i /etc/apt-cacher-ng/acng.conf; \
    echo "http://httpredir.debian.org/debian/" > /etc/apt-cacher-ng/backends_debian; \
    echo "http://archive.ubuntu.com/ubuntu/" > /etc/apt-cacher-ng/backends_ubuntu; \
    \
    rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/* /var/cache/apt/*; \
    rm -f /etc/apt/apt.conf.d/00proxy

COPY assets/ /

WORKDIR /var/cache/apt-cacher-ng
VOLUME [ "/var/cache/apt-cacher-ng" ]
EXPOSE 3142
CMD [ "apt-cacher-ng", "-c", "/etc/apt-cacher-ng" ]

### METADATA ###################################################################

ARG IMAGE
ARG BUILD_DATE
ARG VERSION
ARG VCS_REF
ARG VCS_URL
LABEL \
    org.label-schema.name=$IMAGE \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.version=$VERSION \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url=$VCS_URL \
    org.label-schema.schema-version="1.0"
