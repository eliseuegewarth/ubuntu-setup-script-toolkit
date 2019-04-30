#!/bin/bash

BASIC_INSTALL_MODE="--basic"
FULL_INSTALL_MODE="--full"
SELECTED_INSTALL_MODE="--select-packages --exit"
MODES=($(env | grep "_INSTALL_MODE" | cut -f 2 -d '='))

show_modes(){
    for i in $MODES; do
        show_mode $i
    done
}

show_mode_basic{
    echo "    basic "
}

show_mode_full{
    echo "    full "
}

show_mode_select_packages{
    echo "    select_packages "
}

show_mode(){
    if [[ $1 = *"--basic"* ]]; then
        show_mode_basic
    elif [[ $1 = *"--full"* ]]; then
        show_mode_full
    elif [[ $1 = *"--select-packages"* ]]; then
        show_mode_select_packages
    else
        echo "MODE $1 not exist..."
        echo "This script was corrupted..."
        exit 1
    fi
}

if [[ "$(apt-cache policy curl | grep 'Installed: (none)')" = *"none"* ]]; then
    echo "apt install apt-transport-https curl ..." && \
    sudo apt-get -qq  -y install apt-transport-https curl > /dev/null
fi
if [[ $1 = *"--basic"* ]]; then
    echo "Configuring basic install..."
    echo "Basic config not exist..."
    exit
elif [[ $1 = *"--full"* ]]; then
    if [ -z "${EDITORS}" ]; then
        export EDITORS=""
        export SUBLIME_TEXT="sublime-text"
        export ATOM="atom"
        EDITORS="${EDITORS} ${SUBLIME_TEXT}"
        echo "Preparando sistema para instalação de ${SUBLIME_TEXT}..." && \
        echo "Adicionando chave pública sublime-text ..." && \
        wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add - > /dev/null && \
        echo "Adicionando sublime-text em sources.list ..." && \
        echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list > /dev/null
        EDITORS="${EDITORS} ${ATOM}"
        echo "Preparando sistema para instalação de ${ATOM}..." && \
        echo "Adicionando chave pública Atom ..." && \
        curl -L https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add - > /dev/null && \
        echo "Adicionando Atom em sources.list ..." && \
        sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list' > /dev/null
    fi
    SSH_TOOLS="openssh-server openssh-client"
    DOCKER_COMPOSE_VERSION=$(curl https://api.github.com/repos/docker/compose/releases/latest -s | grep tag_name | cut -f 2 -d":" | cut -f 2 -d'"')
    DISTRO_ARC=$(uname -s)-$(uname -m)
    if [ -z "${CONFIGURADO}" ]; then
        echo "Iniciando configurações..." && \
        export REPO_PATH=$(git rev-parse --show-toplevel) && \
        if [ -z "${REPO_PATH}" ]; then
            REPO_PATH=$PWD;
        fi && \
        FILE_MANAGER="nemo" && \
        cd ${HOME}/Downloads/ && \
        echo "Adicionando ppa do libreoffice..." && \
        sudo add-apt-repository -y ppa:libreoffice/ppa > /dev/null && \
        echo "Adicionando ppa do qbittorrent-stable..." && \
        sudo add-apt-repository -y ppa:qbittorrent-team/qbittorrent-stable > /dev/null && \
        echo "Adicionando chave pública google-chrome-stable ..." && \
        wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - > /dev/null && \
        echo "Adicionando google-chrome-stable em sources.list ..." && \
        echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list > /dev/null && \
        echo "Baixando script nodejs 8.x ..." && \
        curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash - > /dev/null && \
        echo "Adicionando chave pública Spotify ..." && \
        sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90 && \
        echo "Adicionando repositório Spotify ..." && \
        echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
        echo "Adicionando chave pública Docker CE ..." && \
        sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D > /dev/null && \
        echo "Adicionando repositório Docker CE ..." && \
        sudo apt-add-repository -y 'deb https://apt.dockerproject.org/repo ubuntu-xenial main' > /dev/null && \
        echo "apt update ..." && \
        sudo apt-get -qq update > /dev/null && \
        echo "Checando repositório Docker CE ..." && \
        sudo apt-cache policy docker-engine > /dev/null && \
        echo "Add graphics-drivers/ppa..." && \
        sudo add-apt-repository -y ppa:graphics-drivers/ppa && \
        echo "apt install ..." && \
        sudo apt-get -qq -y install nodejs build-essential ${EDITORS} terminator ${SSH_TOOLS} docker-engine python-pip htop > /dev/null && \
        sudo apt-get -qq -y install google-chrome-stable qbittorrent ${FILE_MANAGER} spotify-client libreoffice vlc vlc-data browser-plugin-vlc mplayer2 > /dev/null
        sudo apt -qq -y autoremove;
        echo "Baixando docker-compose ..." && \
        sudo curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-${DISTRO_ARC} -o /usr/local/bin/docker-compose > /dev/null && \
        echo "Adicionando permissões para docker-compose ..." && \
        sudo chmod +x /usr/local/bin/docker-compose;
        echo "Install wps-office..." && \
        cd /tmp/ && \
        echo "Downloading wps-office.deb ..." && \
        wget http://kdl.cc.ksosoft.com/wps-community/download/6757/wps-office_10.1.0.6757_amd64.deb -O wps-office.deb && \
        echo "Downloading wps-office-fonts.deb ..." && \
        wget http://kdl.cc.ksosoft.com/wps-community/download/fonts/wps-office-fonts_1.0_all.deb -O web-office-fonts.deb && \
        echo "Dpkg install wps-office..." && \
        sudo dpkg -i wps-office*.deb &&\
        cd ${REPO_PATH};
        echo "pip install..." && \
        sudo -H pip install --upgrade pip && \
        sudo -H pip install --upgrade setuptools && \
        sudo -H pip install virtualenv virtualenvwrapper ipython ipdb;

        # Setting nemo as default file manager
        xdg-mime default nemo.desktop inode/directory application/x-gnome-saved-search;

        if [[ $EDITORS = *"${SUBLIME_TEXT}"* ]]; then
            # Install Package Control for Sublime Text 3
            SUBLIME_CONFIG_PATH="${HOME}/.config/sublime-text-3"
            mkdir -p ${SUBLIME_CONFIG_PATH}/Installed\ Packages/ && \
            cd ${SUBLIME_CONFIG_PATH}/Installed\ Packages/ && \
            wget https://packagecontrol.io/Package%20Control.sublime-package && \
            mkdir -p ${SUBLIME_CONFIG_PATH}/Packages && \
            cd ${SUBLIME_CONFIG_PATH}/Packages && \
            git clone https://bitbucket.org/hmml/jsonlint.git --single-branch --branch master && \
            git clone https://github.com/djjcast/mirodark-st2 --single-branch --branch master && \
            git clone --single-branch --branch master https://github.com/eliseuegewarth/material-theme.git Material\ Theme && \
            git clone --single-branch --branch master https://github.com/eliseuegewarth/material-theme-appbar.git Material\ Theme\ -\ Appbar && \
            mkdir -p ${SUBLIME_CONFIG_PATH}/Packages/User && \
            cd ${SUBLIME_CONFIG_PATH}/Packages && \
            cp ${REPO_PATH}/Preferences.sublime-settings Preferences.sublime-settings
            cd ${REPO_PATH}
        fi

        # Default terminator settings
        mkdir -p ${HOME}/.config/terminator && \
        cp terminator_config ${HOME}/.config/terminator/config

        # General bash setup
        if [ -z "$(cat ${HOME}/.bashrc | grep bash_env)" ]; then
            echo "Adicionando bash_env em bashrc ..." && \
            echo -e "\nif [ -f ${HOME}/.bash_env ]; then\n    . ${HOME}/.bash_env\nfi" >> ${HOME}/.bashrc;
        fi

        echo "Criando links simbolicos bash_aliases e bash_env ..." && \
        ln -sf ${REPO_PATH}/.bash_aliases ${HOME}/.bash_aliases > /dev/null && \
        ln -sf ${REPO_PATH}/.bash_env ${HOME}/.bash_env > /dev/null;

        # creating workspace
        echo "Criando ${HOME}/workspace se não existir ..." && \
        if [ ! -d $WORKSPACE ]; then
            echo "Configurando WORKSPACE para $WORKSPACE";
            sudo mkdir $WORKSPACE > /dev/null && \
            sudo chown -R $USER:$USER $WORKSPACE > /dev/null
        fi

        echo "Clonando repositórios ..." && \
        cd ${WORKSPACE} && source ${REPO_PATH}/git_start.sh  > /dev/null;
        echo "Finalizando configurações ..." && \
        export CONFIGURADO="true" > /dev/null && \
        echo 'export CONFIGURADO="true";'  >> ${HOME}/.bash_env;
    else
        echo "Tudo configurado!";
    fi
else
    echo "$0 [MODE]"
    echo "Install a set of programs."
    show_modes
fi
