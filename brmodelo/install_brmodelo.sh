#!/bin/bash
#require sudo

basedirname="$(dirname "$0")"
cd $basedirname

brmodelo_path="/opt/brmodelo"

# Removing previous version of brmodelo
rm -rf ${brmodelo_path}/ && mkdir -p ${brmodelo_path}/ && chmod 777 ${brmodelo_path}

./download_brmodelo.sh $brmodelo_path

cp brmodelo.sh "${brmodelo_path}/"

./create_desktop_file.sh

echo "Finished Setup..."
