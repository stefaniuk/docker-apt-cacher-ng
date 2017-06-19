#!/bin/bash
set -e

mkdir -p \
    /var/cache/apt-cacher-ng \
    /var/log/apt-cacher-ng
chown -R $SYSTEM_USER:$SYSTEM_USER \
    /var/cache/apt-cacher-ng \
    /var/log/apt-cacher-ng
chmod 644 /etc/apt-cacher-ng/*

tail -F /var/log/apt-cacher-ng/apt-cacher.out > /dev/stdout 2> /dev/null &
tail -F /var/log/apt-cacher-ng/apt-cacher.err > /dev/stderr 2> /dev/null &
