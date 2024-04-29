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
		--env-file .env \
		--name $(DOCKER_NAME) $(DOCKER_NAME)

docker-ansible-password:
	@echo $(ANSIBLE_VAULT_PASS) > docker/files/.ssh/ansible_vault_pass

docker-ansible-encrypt: docker-ansible-password
	docker run --rm \
		-v $(shell pwd):/opt \
		$(DOCKER_NAME) \
		/usr/bin/ansible-vault encrypt --vault-password-file=/opt/docker/files/.ssh/ansible_vault_pass /opt/docker/files/.ssh/id_rsa_vm

docker-ansible-decrypt: docker-ansible-password
	docker run --rm \
		-v $(shell pwd):/opt \
		$(DOCKER_NAME) \
		/usr/bin/ansible-vault decrypt --vault-password-file=/opt/docker/files/.ssh/ansible_vault_pass /opt/docker/files/.ssh/id_rsa_vm

init:
	docker run --rm \
		-v $(shell pwd):/opt \
		--env-file .env \
		$(DOCKER_NAME) \
		/usr/bin/bash /opt/bash/init.sh

plan: init
	docker run --rm \
		-v $(shell pwd):/opt \
		--env-file .env \
		$(DOCKER_NAME) \
		/usr/bin/bash /opt/bash/plan.sh

apply:
	docker run --rm \
		-v $(shell pwd):/opt \
		--env-file .env \
		$(DOCKER_NAME) \
		/usr/bin/bash /opt/bash/apply.sh

destroy:
	@echo "Are you sure you want to destroy all? y/n";\
	read INPUT;\
	if [ "$$INPUT" = "y" ]; then \
	docker run --rm \
		-v $(shell pwd):/opt \
		--env-file .env \
		$(DOCKER_NAME) \
		/usr/bin/bash /opt/bash/destroy.sh; \
	fi
