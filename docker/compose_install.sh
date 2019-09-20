#!/bin/bash
DOCKER_COMPOSE_VERSION=$(curl https://api.github.com/repos/docker/compose/releases/latest -s | grep tag_name | cut -f 2 -d":" | cut -f 2 -d'"')
DISTRO_ARC=$(uname -s)-$(uname -m)
echo "Baixando docker-compose ..." && \
curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-${DISTRO_ARC} -o /usr/local/bin/docker-compose > /dev/null && \
echo "Adicionando permissões para docker-compose ..." && \
chmod +x /usr/local/bin/docker-compose;