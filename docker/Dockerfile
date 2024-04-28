FROM linuxcontainers/debian-slim:12.5

WORKDIR /tmp

RUN apt-get update && apt-get install gpg wget lsb-release python3 python3-pip -y
RUN wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com bookworm main" | tee /etc/apt/sources.list.d/hashicorp.list
RUN apt-get update && apt-get install terraform -y

# ENTRYPOINT ["/usr/bin/sleep", "999999"]