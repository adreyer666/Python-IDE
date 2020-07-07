#!/usr/bin/env make

IMAGE = python-ide

build: Makefile Dockerfile
	buildah bud -f Dockerfile -t $(IMAGE)

test:
	./python-ide

clean:
	podman image rm localhost/$(IMAGE)

