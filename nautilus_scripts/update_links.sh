#!/bin/bash
od="$PWD"
cd "$(dirname "$0")"
IFS=$'\n'
script_path="${HOME}/.local/share/nautilus/scripts/"
for i in $(ls | grep -v ".sh");
do
	ln -Tf "${i}" "${script_path}${i}";
	chmod +x "${script_path}${i}";
done
cd "${od}"
