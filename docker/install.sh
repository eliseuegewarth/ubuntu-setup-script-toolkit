#!/bin/bash
if [ "18.04" == "$(lsb_release -rs)" ]; then
	cd /tmp/
	apt install apt-transport-https ca-certificates curl software-properties-common -y
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
	add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
	apt update
	apt-cache policy docker-ce
	apt install docker-ce -y
else
	echo "There is no setup for your system version..."
fi