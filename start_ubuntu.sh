#!/bin/bash
MODES=""
BASIC_INSTALL_MODE="--basic"
MODES="$MODES $BASIC_INSTALL_MODE"
FULL_INSTALL_MODE="--full"
MODES="$MODES $FULL_INSTALL_MODE"
SELECTED_INSTALL_MODE="--select-packages"
MODES="$MODES $SELECTED_INSTALL_MODE"

show_modes(){
    for i in $MODES; do
        show_mode $i
    done
}

show_mode_basic(){
    echo "    --basic"
}

show_mode_full(){
    echo "    --full"
}

show_mode_select_packages(){
    echo "    --select_packages"
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
    SSH_TOOLS="openssh-server openssh-client"
    DOCKER_COMPOSE_VERSION=$(curl https://api.github.com/repos/docker/compose/releases/latest -s | grep tag_name | cut -f 2 -d":" | cut -f 2 -d'"')
    DISTRO_ARC=$(uname -s)-$(uname -m)
    if [ -z "${CONFIGURADO}" ]; then
        echo "Iniciando configurações..." && \
        export REPO_PATH=$(git rev-parse --show-toplevel) && \
        if [ -z "${REPO_PATH}" ]; then
            REPO_PATH=$PWD;
        fi && \
        ${REPO_PATH}/sublime_text/pre_install.sh
        ${REPO_PATH}/atom/pre_install.sh
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
        sudo apt-get -qq -y install nodejs build-essential terminator ${SSH_TOOLS} htop > /dev/null && \
        sudo apt-get -qq -y install google-chrome-stable qbittorrent spotify-client vlc vlc-data browser-plugin-vlc > /dev/null
        sudo apt-get -qq -y install atom sublime_text > /dev/null && \
        sudo apt -qq -y autoremove;
        echo "Baixando docker-compose ..." && \
        sudo curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-${DISTRO_ARC} -o /usr/local/bin/docker-compose > /dev/null && \
        echo "Adicionando permissões para docker-compose ..." && \
        sudo chmod +x /usr/local/bin/docker-compose;
        ${REPO_PATH}/install_pip_packages.sh

        # Sublime post
        ${REPO_PATH}/sublime_text/post_config.sh

        # Setting nemo as default file manager
        xdg-mime default nemo.desktop inode/directory application/x-gnome-saved-search;

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
