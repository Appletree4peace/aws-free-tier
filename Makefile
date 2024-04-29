# load and export .env
ifneq (,$(wildcard ./.env))
    include .env
    export
endif

# docker jobs
## docker build
docker-build:
	docker build \
		--build-arg USER_UID=$(shell id -u) \
		--build-arg USER_GID=$(shell id -g) \
		-t $(DOCKER_NAME) \
		-f docker/Dockerfile .

debug: docker-ansible-password
	docker run -it --rm \
		-v $(shell pwd):/opt \
		--name $(DOCKER_NAME) $(DOCKER_NAME)

docker-ansible-password:
	@echo $(ANSIBLE_VAULT_PASS) > docker/files/.ssh/ansible_vault_pass

docker-ansible-encrypt: docker-ansible-password
	cd docker/files/.ssh && docker run --rm \
		-v $(shell pwd):/opt \
		$(DOCKER_NAME) \
		/usr/bin/ansible-vault encrypt --vault-password-file=/opt/docker/files/.ssh/ansible_vault_pass /opt/docker/files/.ssh/id_rsa_vm

docker-ansible-decrypt: docker-ansible-password
	cd docker/files/.ssh && docker run --rm \
		-v $(shell pwd):/opt \
		$(DOCKER_NAME) \
		/usr/bin/ansible-vault decrypt --vault-password-file=/opt/docker/files/.ssh/ansible_vault_pass /opt/docker/files/.ssh/id_rsa_vm

init:
	docker run --rm \
		-v $(shell pwd):/opt \
		$(DOCKER_NAME) \
		/usr/bin/bash bash/
