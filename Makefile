TM := $(shell date +%Y%m%d)
UPV := $(shell grep 'ENV VERSION' Dockerfile | sed 's/\(.*upwork_\)\([^_]\+\)\(.*\)/\2/')

build:
	docker build \
		-t skopciewski/upwork:$(UPV) \
		--build-arg BUILDKIT_INLINE_CACHE=1 \
		--cache-from skopciewski/upwork:$(UPV) \
		.
.PHONY: build

push:
	docker push skopciewski/upwork:$(UPV)
	docker tag skopciewski/upwork:$(UPV) skopciewski/devenv-ruby:$(UPV)_$(TM)
	docker tag skopciewski/upwork:$(UPV) skopciewski/devenv-ruby:latest
	docker push skopciewski/upwork:$(UPV)_$(TM)
	docker push skopciewski/upwork:latest

.PHONY: push

push_all:
	docker push skopciewski/devenv-ruby
.PHONY: push_all
