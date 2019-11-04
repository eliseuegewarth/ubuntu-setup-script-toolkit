#!/bin/bash
#require sudo
brmodelo_path="$1"
if [ -z "$brmodelo_path" ]; then
    brmodelo_path="/tmp/brmodelo"
    mkdir -p $brmodelo_path
fi
wget http://www.sis4.com/brModelo/brModelo.jar -O ${brmodelo_path}/brModelo.jar
wget https://github.com/chcandido/brModelo/raw/master/src/imagens/icone.png -O ${brmodelo_path}/brmodelo.png
