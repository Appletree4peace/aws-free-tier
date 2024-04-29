FROM linuxcontainers/debian-slim:12.5

WORKDIR /tmp

ARG USER_UID=1000
ARG USER_GID=1000

## user
RUN addgroup --gid ${USER_GID} appletree
RUN adduser --disabled-password --uid ${USER_UID} --ingroup appletree --home /home/appletree --shell /bin/bash appletree

## terraform
RUN apt-get update && apt-get install gpg wget -y
RUN wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com bookworm main" | tee /etc/apt/sources.list.d/hashicorp.list
RUN apt-get update && apt-get install terraform -y

## system packages
RUN apt-get update && apt-get install python3 python3-pip unzip -y

## aws cli v2
RUN wget https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -O awscliv2.zip
RUN unzip awscliv2.zip
RUN cd aws && ./install
RUN rm -rf aws*

## ansible
RUN apt-get install ansible -y



## ssh keys
COPY docker/files/.ssh/id_rsa_vm /home/appletree/.ssh/id_rsa
COPY docker/files/.ssh/id_rsa_vm.pub /home/appletree/.ssh/id_rsa.pub
COPY docker/files/.ssh/ansible_vault_pass /home/appletree/.ssh/ansible_vault_pass
RUN ansible-vault decrypt --vault-password-file=/home/appletree/.ssh/ansible_vault_pass /home/appletree/.ssh/id_rsa
RUN chown appletree:appletree /home/appletree/.ssh/id_rsa*

USER appletree
WORKDIR /opt


# ENTRYPOINT ["/usr/bin/sleep", "999999"]