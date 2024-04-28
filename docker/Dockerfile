FROM linuxcontainers/debian-slim:12.5

RUN mkdir /opt/docker
RUN mkdir /opt/terraform
WORKDIR /tmp


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
RUN rm -rf aws


# ENTRYPOINT ["/usr/bin/sleep", "999999"]