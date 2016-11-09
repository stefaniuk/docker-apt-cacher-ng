[![Circle CI](https://circleci.com/gh/stefaniuk/docker-apt-cacher-ng.svg?style=shield "CircleCI")](https://circleci.com/gh/stefaniuk/docker-apt-cacher-ng)&nbsp;[![Size](https://images.microbadger.com/badges/image/stefaniuk/apt-cacher-ng.svg)](http://microbadger.com/images/stefaniuk/apt-cacher-ng)&nbsp;[![Version](https://images.microbadger.com/badges/version/stefaniuk/apt-cacher-ng.svg)](http://microbadger.com/images/stefaniuk/apt-cacher-ng)&nbsp;[![Commit](https://images.microbadger.com/badges/commit/stefaniuk/apt-cacher-ng.svg)](http://microbadger.com/images/stefaniuk/apt-cacher-ng)&nbsp;[![Docker Hub](https://img.shields.io/docker/pulls/stefaniuk/apt-cacher-ng.svg)](https://hub.docker.com/r/stefaniuk/apt-cacher-ng/)

Docker Apt-Cacher NG
====================

Set up a repository cache on your network so that once a Linux package is downloaded from an official repository, all other machines will download it from your local area network.

Installation
------------

Builds of the image are available on [Docker Hub](https://hub.docker.com/r/stefaniuk/apt-cacher-ng/).

    docker pull stefaniuk/apt-cacher-ng

Alternatively you can build the image yourself.

    docker build --tag stefaniuk/apt-cacher-ng \
        github.com/stefaniuk/docker-apt-cacher-ng

Quickstart
----------

Start container using:

    docker run --detach --restart always \
        --name apt-cacher-ng \
        --hostname apt-cacher-ng \
        --publish 3142:3142 \
        stefaniuk/apt-cacher-ng

See
---

- [Apt-Cacher NG](https://www.unix-ag.uni-kl.de/~bloch/acng/)
