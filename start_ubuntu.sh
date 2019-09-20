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
    if [ -z "${CONFIGURADO}" ]; then
        echo "Iniciando configurações..." && \
        export REPO_PATH=$(git rev-parse --show-toplevel) && \
        if [ -z "${REPO_PATH}" ]; then
            REPO_PATH=$PWD;
        fi && \
        ${REPO_PATH}/sublime_text/pre_install.sh
        ${REPO_PATH}/atom/pre_install.sh
        cd ${HOME}/Downloads/ && \
        echo "Adicionando chave pública google-chrome-stable ..." && \
        wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - > /dev/null && \
        echo "Adicionando google-chrome-stable em sources.list ..." && \
        echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list > /dev/null && \
        echo "Baixando script nodejs 8.x ..." && \
        curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash - > /dev/null && \
        echo "apt update ..." && \
        sudo apt-get -qq update > /dev/null && \
        echo "apt install ..." && \
        sudo apt-get -qq -y install nodejs build-essential terminator ${SSH_TOOLS} htop > /dev/null && \
        sudo apt-get -qq -y install google-chrome-stable vlc vlc-data browser-plugin-vlc > /dev/null
        sudo apt-get -qq -y install atom sublime-text > /dev/null && \
        sudo apt -qq -y autoremove;
        ${REPO_PATH}/install_pip_packages.sh

        # Sublime post
        ${REPO_PATH}/sublime_text/post_config.sh

        # Setting nemo as default file manager
        xdg-mime default nemo.desktop inode/directory application/x-gnome-saved-search;

        # Default terminator settings
        mkdir -p ${HOME}/.config/terminator && \
        cd ${REPO_PATH} && \
        cp ${REPO_PATH}/terminator_config ${HOME}/.config/terminator/config

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
