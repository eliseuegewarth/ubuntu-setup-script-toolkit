#!/bin/bash
apt update && apt upgrade -y && apt autoremove -y && apt autoclean && \
if [ -z $1 ]
then
	echo "Nothing to do...";
elif [[ $1 = *"--shutdown"* ]]
then
	shutdown -P now;
elif [[ $1 = *"--restart"* ]]
then
	reboot;
fi && exit 0 || exit 1;
