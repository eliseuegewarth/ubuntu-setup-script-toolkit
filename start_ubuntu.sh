#!/bin/bash
echo "apt install apt-transport-https curl ..." && \
sudo apt-get -qq  -y install apt-transport-https curl > /dev/null

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
    echo "Adicionando ppa do qbittorrent-stable..." && \
    sudo add-apt-repository -y ppa:qbittorrent-team/qbittorrent-stable > /dev/null && \
    echo "Adicionando chave pública google-chrome-stable ..." && \
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - > /dev/null && \
    echo "Adicionando google-chrome-stable em sources.list ..." && \
    echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list > /dev/null && \
    echo "Baixando script nodejs 8.x ..." && \
    curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash - > /dev/null && \
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
    sudo apt-get -qq -y install nodejs build-essential google-chrome-stable ${EDITORS} terminator qbittorrent ${SSH_TOOLS} vlc docker-engine python-pip htop ${FILE_MANAGER} > /dev/null && \
    echo "Baixando docker-compose ..." && \
    sudo curl -L https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-${DISTRO_ARC} -o /usr/local/bin/docker-compose > /dev/null && \
    echo "Adicionando permissões para docker-compose ..." && \
    sudo chmod +x /usr/local/bin/docker-compose && \
    echo "snap install wps-office..." && \
    sudo snap install wps-office && \
    echo "snap install spotify..." && \
    sudo snap install spotify && \
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

    # General interface settings
    echo "gsettings clock-show-date true ..." && \
    gsettings set org.gnome.desktop.interface clock-show-date "true" > /dev/null;
    # setting touchpad options
    echo "gsettings natural-scroll true ..." && \
    gsettings set org.gnome.desktop.peripherals.touchpad natural-scroll true && \
    echo "gsettings tap-to-click true ..." && \
    gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true;
    # image background
    echo "gsettings image background ..." && \
    sudo cp ${REPO_PATH}/img/background.png /usr/share/backgrounds/background.png > /dev/null && \
    sudo cp ${REPO_PATH}/img/lockscreen.png /usr/share/backgrounds/lockscreen.png > /dev/null && \
    sudo cp ${REPO_PATH}/img/grub_background.png /usr/share/backgrounds/grub_background.png > /dev/null && \
    sudo cp ${REPO_PATH}/img/background.png /usr/share/backgrounds/ubuntu-gnome/background.png > /dev/null && \
    gsettings set org.gnome.desktop.background picture-uri 'file:///usr/share/backgrounds/background.png' > /dev/null && \
    gsettings set org.gnome.desktop.screensaver picture-uri 'file:///usr/share/backgrounds/lockscreen.png' > /dev/null;
    # setting default favorite launcher apps
    gsettings set org.gnome.shell favorite-apps "['nemo.desktop', 'google-chrome.desktop', 'firefox.desktop', 'sublime_text.desktop', 'terminator.desktop']"

    # Enable alternatetab and user-theme extensions
    gsettings set org.gnome.shell enabled-extensions "['user-theme@gnome-shell-extensions.gcampax.github.com', 'alternate-tab@gnome-shell-extensions.gcampax.github.com']"

    # Setting up Gnome workspaces default
    gsettings set org.gnome.desktop.wm.preferences num-workspaces 1
    gsettings set org.gnome.shell.overrides dynamic-workspaces false

    # Icon theme
    echo "gsettings icon-theme 'Flat-Remix-Dark'..." && \
    cd /tmp && rm -rf flat-remix && \
    git clone https://github.com/eliseuegewarth/flat-remix && \
    mkdir -p ${HOME}/.icons && cp -r flat-remix/Flat-Remix* ${HOME}/.icons/ && \
    gsettings set org.gnome.desktop.interface icon-theme "Flat-Remix-Dark" > /dev/null;

    # Shell Theme
    echo "gsettings shell theme 'Flat-Remix-Darkest'..." && \
    cd /tmp && rm -rf flat-remix-gnome && \
    git clone https://github.com/eliseuegewarth/flat-remix-gnome.git --branch master --single-branch && \
    mkdir -p ${HOME}/.themes && rm -rf ${HOME}/.themes/Flat-Remix* && \
    cp -rf /tmp/flat-remix-gnome/Flat-Remix* ${HOME}/.themes && \
    gsettings set org.gnome.shell.extensions.user-theme name "Flat-Remix-Darkest" > /dev/null;

    # Cursor Theme
    echo "gsettings shell theme 'Bibata Cursor'..." && \
    cd /tmp && rm -rf Bibata_Cursor && \
    sudo apt install -y inkscape && \
    git clone https://github.com/eliseuegewarth/Bibata_Cursor.git && \
    cd Bibata_Cursor/ && \
    chmod +x build.sh && \
    ./build.sh && \
    chmod +x ./Installer_Bibata.sh && \
    ./Installer_Bibata.sh && \
    gsettings set org.gnome.desktop.interface cursor-theme 'Bibata_Oil'

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
