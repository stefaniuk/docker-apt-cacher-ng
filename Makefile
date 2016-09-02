ifdef GITHUB_ACCOUNT
	ACCOUNT := $(GITHUB_ACCOUNT)
else
	ACCOUNT := $(USER)
endif
CONTAINER := $(subst docker-,,$(shell basename $(shell dirname $(realpath  $(lastword $(MAKEFILE_LIST))))))
REPOSITORY :=  $(ACCOUNT)/$(CONTAINER)

all: help

help:
	@echo
	@echo "Usage:"
	@echo
	@echo "    make build|release|push APT_PROXY=url"
	@echo "    make start|log|bash|stop"
	@echo "    make clean|prune"
	@echo

build:
	@docker build \
		--build-arg "APT_PROXY=$(APT_PROXY)" \
		--tag $(REPOSITORY) --rm .

release: build
	@docker build \
		--build-arg "APT_PROXY=$(APT_PROXY)" \
		--tag $(REPOSITORY):$(shell cat VERSION) --rm .

push: release
	@docker push $(REPOSITORY):$(shell cat VERSION)

start:
	@docker run --detach \
		--name $(CONTAINER) \
		--hostname $(CONTAINER) \
		--volume $(shell pwd)/data:/var/cache/apt-cacher-ng \
		--publish 3142:3142 \
		$(REPOSITORY)

log:
	@docker logs --follow $(CONTAINER)

bash:
	@docker exec --interactive --tty $(CONTAINER) /bin/bash

stop:
	@docker stop $(CONTAINER) > /dev/null 2>&1 ||:

clean: stop
	@docker rm $(CONTAINER) > /dev/null 2>&1 ||:

prune: clean
	@docker rmi $(REPOSITORY) > /dev/null 2>&1 ||:
	@docker rmi $(REPOSITORY):$(shell cat VERSION) > /dev/null 2>&1 ||:
