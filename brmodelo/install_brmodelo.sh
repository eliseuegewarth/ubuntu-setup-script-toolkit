#!/bin/bash
#require sudo

basedirname="$(dirname "$0")"
cd $basedirname

if [[ $1 = *"--user"* ]]; then
    brmodelo_path="$HOME/.local/share/brmodelo"
    permissions='echo "running as user"'
elif [[ $1 = *"--all"* ]]; then
    brmodelo_path="/opt/brmodelo"
    permissions="chmod 777 ${brmodelo_path}"
else
    echo "Run with argument '--user' or '--all'."
    exit 0;
fi

# Removing previous version of brmodelo
rm -rf ${brmodelo_path}/ && mkdir -p ${brmodelo_path}/ && eval $permissions

source ./download_brmodelo.sh $1

cp brmodelo.sh "${brmodelo_path}/"
chmod 755 ${brmodelo_path}/brmodelo.sh

source ./create_desktop_file.sh $1

echo "Finished Setup..."
