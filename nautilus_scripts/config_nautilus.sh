#!/bin/bash
od="$PWD"
cd "$(dirname "$0")"
mkdir -p ${HOME}/.local/share/nautilus/scripts/
./update_links.sh
cd "${od}"
