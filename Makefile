# load and export .env
ifneq (,$(wildcard ./.env))
    include .env
    export
endif

# docker jobs
## docker build
docker-build:
	docker build -t $(DOCKER_NAME) -f docker/Dockerfile .

debug:
	docker run -it --rm -v docker:/opt/docker --name $(DOCKER_NAME) $(DOCKER_NAME)

