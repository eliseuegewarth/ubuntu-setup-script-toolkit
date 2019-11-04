#!/bin/bash
#require sudo

if [[ $1 = *"--user"* ]]; then
    brmodelo_path="$HOME/.local/share/brmodelo"
elif [[ $1 = *"--all"* ]]; then
    brmodelo_path="/opt/brmodelo"
else
    echo "Run with argument '--user' or '--all'."
    exit 0;
fi

wget http://www.sis4.com/brModelo/brModelo.jar -O ${brmodelo_path}/brModelo.jar
wget https://github.com/chcandido/brModelo/raw/master/src/imagens/icone.png -O ${brmodelo_path}/brmodelo.png
