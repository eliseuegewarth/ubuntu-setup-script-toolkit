#!/bin/bash
echo "Preparando sistema para instalação de ${ATOM}..."
echo "Adicionando chave pública Atom ..."
curl -L https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
echo "Adicionando Atom em sources.list ..."
sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'
