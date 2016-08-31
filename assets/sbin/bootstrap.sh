#!/bin/bash

mkdir -p /etc/apt-cacher-ng
chown -R root:root /etc/apt-cacher-ng
chmod 644 /etc/apt-cacher-ng/*

mkdir -p /var/{cache,log}/apt-cacher-ng
chown -R $SYSTEM_USER:$SYSTEM_USER \
    /var/cache/apt-cacher-ng \
    /var/log/apt-cacher-ng

# SEE: https://github.com/docker/docker/issues/6880
ln -sf /dev/tty /var/log/apt-cacher-ng/apt-cacher.out
ln -sf /dev/tty /var/log/apt-cacher-ng/apt-cacher.err
