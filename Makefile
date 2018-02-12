TARGETS := $(shell cat $(realpath $(lastword $(MAKEFILE_LIST))) | grep "^[a-z]*:" | awk '{ print $$1; }' | sed 's/://g' | grep -vE 'all|help' | paste -sd "|" -)
NAME := $(subst docker-,,$(shell basename $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))))
IMAGE := codeworksio/$(NAME)

all: help

help:
	echo
	echo "Usage:"
	echo
	echo "    make $(TARGETS) [APT_PROXY|APT_PROXY_SSL=ip:port]"
	echo

build:
	docker build \
		--build-arg APT_PROXY=$(APT_PROXY) \
		--build-arg APT_PROXY_SSL=$(APT_PROXY_SSL) \
		--build-arg IMAGE=$(IMAGE) \
		--build-arg BUILD_DATE=$(shell date -u +"%Y-%m-%dT%H:%M:%SZ") \
		--build-arg VERSION=$(shell cat VERSION) \
		--build-arg VCS_REF=$(shell git rev-parse --short HEAD) \
		--build-arg VCS_URL=$(shell git config --get remote.origin.url) \
		--tag $(IMAGE):$(shell cat VERSION) \
		--rm .
	docker tag $(IMAGE):$(shell cat VERSION) $(IMAGE):latest
	docker rmi --force $$(docker images | grep "<none>" | awk '{ print $$3 }') 2> /dev/null ||:

start:
	docker run --detach --interactive --tty --restart always \
		--name $(NAME) \
		--hostname $(NAME) \
		--env "INIT_DEBUG=true" \
		--volume $(shell pwd)/mounts/var/cache/apt-cacher-ng:/var/cache/apt-cacher-ng \
		--publish 3142:3142 \
		$(IMAGE) \

stop:
	docker stop $(NAME) > /dev/null 2>&1 ||:
	docker rm $(NAME) > /dev/null 2>&1 ||:

log:
	docker logs --follow $(NAME)

test:
	docker run --detach --interactive --tty --name apt-cacher-ng codeworksio/apt-cacher-ng
	sleep 10
	docker logs apt-cacher-ng | grep "Listening to incoming connections"

bash:
	docker exec --interactive --tty \
		--user root \
		$(NAME) \
		/bin/bash --login ||:

clean:
	docker rmi $(IMAGE):$(shell cat VERSION) > /dev/null 2>&1 ||:
	docker rmi $(IMAGE):latest > /dev/null 2>&1 ||:

push:
	docker push $(IMAGE):$(shell cat VERSION)
	docker push $(IMAGE):latest
	sleep 10
	curl --request POST "https://hooks.microbadger.com/images/$(IMAGE)/MeSOunWnEO-cbDU6aYdPkl1PVqs="

.SILENT:
