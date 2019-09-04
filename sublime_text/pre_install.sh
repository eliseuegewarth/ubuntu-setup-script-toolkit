#!/bin/bash
echo "Preparando sistema para instalação de ${SUBLIME_TEXT}..."
echo "Adicionando chave pública sublime-text ..."
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
echo "Adicionando sublime-text em sources.list ..." && \
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
echo "RUN apt update before apt install..."
