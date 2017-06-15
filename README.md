[![Circle CI](https://circleci.com/gh/codeworksio/docker-apt-cacher-ng.svg?style=shield "CircleCI")](https://circleci.com/gh/codeworksio/docker-apt-cacher-ng)&nbsp;[![Size](https://images.microbadger.com/badges/image/codeworksio/apt-cacher-ng.svg)](http://microbadger.com/images/codeworksio/apt-cacher-ng)&nbsp;[![Version](https://images.microbadger.com/badges/version/codeworksio/apt-cacher-ng.svg)](http://microbadger.com/images/codeworksio/apt-cacher-ng)&nbsp;[![Commit](https://images.microbadger.com/badges/commit/codeworksio/apt-cacher-ng.svg)](http://microbadger.com/images/codeworksio/apt-cacher-ng)&nbsp;[![Docker Hub](https://img.shields.io/docker/pulls/codeworksio/apt-cacher-ng.svg)](https://hub.docker.com/r/codeworksio/apt-cacher-ng/)

Docker Apt-Cacher NG
====================

Set up a repository cache on your network so that once a Linux package is downloaded from an official repository, all other machines will download it from your local area network.

Installation
------------

Builds of the image are available on [Docker Hub](https://hub.docker.com/r/codeworksio/apt-cacher-ng/).

    docker pull codeworksio/apt-cacher-ng

Alternatively you can build the image yourself.

    docker build --tag codeworksio/apt-cacher-ng \
        github.com/codeworksio/docker-apt-cacher-ng

Quickstart
----------

Start container using:

    docker run --detach --restart always \
        --name apt-cacher-ng \
        --hostname apt-cacher-ng \
        --publish 3142:3142 \
        codeworksio/apt-cacher-ng

See
---

* [Apt-Cacher NG](https://www.unix-ag.uni-kl.de/~bloch/acng/)
