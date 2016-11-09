#!/bin/bash
set -e

mkdir -p /etc/apt-cacher-ng
chown -R root:root /etc/apt-cacher-ng
chmod 644 /etc/apt-cacher-ng/*

mkdir -p /var/{cache,log}/apt-cacher-ng
chown -R $SYSTEM_USER:$SYSTEM_USER \
    /var/cache/apt-cacher-ng \
    /var/log/apt-cacher-ng

tail -F /var/log/apt-cacher-ng/apt-cacher.out > /dev/stdout 2> /dev/null &
tail -F /var/log/apt-cacher-ng/apt-cacher.err > /dev/stderr 2> /dev/null &
