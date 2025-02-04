DOCKER_BAKE_FILE := -f Makefile.docker-bake.hcl
ALPINE_VERSION := 3.16

DOCKER_META_IMAGES := gpickin/libreoffice-unoserver
DOCKER_META_VERSION := test

it:
	@echo "Please use \`make <target>\` where <target> is one of"
	@echo "  build        to build docker image"
	@echo "  push         to push docker image"
	@echo "  run          to run docker image"
	@echo "  shell        to run docker image with shell"

build:
	DOCKER_META_IMAGES=${DOCKER_META_IMAGES} DOCKER_META_VERSION=${DOCKER_META_VERSION} \
	ALPINE_VERSION=${ALPINE_VERSION} \
	docker buildx bake --load $(DOCKER_BAKE_FILE)

push:
	docker push ${DOCKER_META_IMAGES}:${DOCKER_META_VERSION}

run:
	docker run -it --rm -p 8443:8443 ${DOCKER_META_IMAGES}:${DOCKER_META_VERSION}

shell:
	docker run -it --rm -p 8443:8443 ${DOCKER_META_IMAGES}:${DOCKER_META_VERSION} sh
