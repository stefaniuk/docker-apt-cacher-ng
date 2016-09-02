#!/bin/bash

mkdir -p /etc/apt-cacher-ng
chown -R root:root /etc/apt-cacher-ng
chmod 644 /etc/apt-cacher-ng/*

mkdir -p /var/{cache,log}/apt-cacher-ng
chown -R $SYSTEM_USER:$SYSTEM_USER \
    /var/cache/apt-cacher-ng \
    /var/log/apt-cacher-ng

# SEE: https://github.com/docker/docker/issues/6880
#su -c "ln -sf /dev/tty /var/log/apt-cacher-ng/apt-cacher.out" $SYSTEM_USER
#su -c "ln -sf /dev/tty /var/log/apt-cacher-ng/apt-cacher.err" $SYSTEM_USER

#tail -F /var/log/apt-cacher-ng/apt-cacher.out > /dev/stdout &
#tail -F /var/log/apt-cacher-ng/apt-cacher.err > /dev/stderr &
