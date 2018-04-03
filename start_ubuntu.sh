#!/bin/bash
if [ -z "${CONFIGURADO}" ]; then
	echo "Iniciando configurações...";
	cd ~/Downloads/;

	# install nodejs 8, sublime text 3
	sudo apt-get install -y apt-transport-https curl && \
	wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add - && \
	echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list && \
	wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - && \
	echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list && \
	curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash - && \
	curl -L https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add - && \
	sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list' && \
	sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D && \
	sudo apt-add-repository 'deb https://apt.dockerproject.org/repo ubuntu-xenial main' && \
	sudo apt-get -qq update && \
	sudo apt-cache policy docker-engine && \
	sudo apt-get -qq -y install nodejs build-essential google-chrome-stable sublime-text atom terminator docker-engine > /dev/null;
	sudo curl -L https://github.com/docker/compose/releases/download/1.20.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose && \
	sudo chmod +x /usr/local/bin/docker-compose && \



	# General interface settings
	gsettings set org.gnome.desktop.interface clock-show-date "true";

	# image background
	sudo cp img/background.jpg /usr/share/backgrounds/background.jpg;
	sudo cp img/background.jpg /usr/share/backgrounds/ubuntu-gnome/background.jpg;
	gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/background.jpg';

	# Icon theme
	sudo cd /usr/share/icons/ && git clone https://github.com/rudrab/Shadow.git --branch master --single-branch;
	gsettings set org.gnome.desktop.interface icon-theme "Shadow";

	# Shell Theme
	cd /tmp && rm -rf flat-remix-gnome-theme && \
	git clone https://github.com/daniruiz/flat-remix-gnome.git --branch master --single-branch && \
	mkdir -p ~/.themes && cp -r /tmp/flat-remix-gnome/Flat-Remix* ~/.themes && \
	gsettings set org.gnome.shell.extensions.user-theme name "Flat-Remix-dark";

	# General bash setup
	echo $'\nif [ -f ~/.bash_env ]; then\n    . ~/.bash_env\nfi' >> ~/.bashrc;

	ln -sf $(git rev-parse --show-toplevel)/.bash_aliases ~/.bash_aliases;
	ln -sf $(git rev-parse --show-toplevel)/.bash_env ~/.bash_env;

	. ~/.bashrc;



	# creating workspace
	if [ ! -d $WORKSPACE ]; then
	    echo "Configurando WORKSPACE para $WORKSPACE";
		sudo mkdir $WORKSPACE;
		sudo chown -R $USER:$USER $WORKSPACE;
	fi

	source git_start.sh

	sudo npm install -g react-native-cli
	export CONFIGURADO=true;
	echo 'export CONFIGURADO=true;'  >> ~/.bash_env;
	reload;
else
	echo "Tudo configurado!";
fi

