#!/bin/bash
# Config ssh
if [ ! -f $HOME/.ssh/id_rsa ]; then
	export REPO_PATH=$(git rev-parse --show-toplevel);
	source ${REPO_PATH}/.secret_env
	ssh-keygen -t rsa -b 4096 -N $PASSWORD -C "${GIT_USER_EMAIL}" -f $HOME/.ssh/id_rsa
	eval "$(ssh-agent -s)"
	ssh-add ~/.ssh/id_rsa;
	echo "Chave gerada e adicionada ao ssh-agent. Adicione a chave ao seu repositório."
        cat ~/.ssh/id_rsa.pub;
else
	echo "Já existe uma chave SSH configurada."
fi
