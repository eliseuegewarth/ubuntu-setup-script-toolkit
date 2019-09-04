#!/bin/bash
echo "Baixando docker-compose ..." && \
sudo curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-${DISTRO_ARC} -o /usr/local/bin/docker-compose > /dev/null && \
echo "Adicionando permissões para docker-compose ..." && \
sudo chmod +x /usr/local/bin/docker-compose;