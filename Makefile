#!/usr/bin/env make

IMAGE = devops

build: Makefile Dockerfile
	buildah bud -f Dockerfile -t $(IMAGE)

run:
	x11docker --podman --sudouser --user=RETAIN --xpra --pulseaudio $(IMAGE)

clean:
	podman image rm localhost/$(IMAGE)

