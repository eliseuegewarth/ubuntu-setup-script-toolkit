#!/bin/bash
export REPO_PATH=$(git rev-parse --show-toplevel) && \
if [ -z "${REPO_PATH}" ]; then
    REPO_PATH=$PWD;
fi && \
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
gsettings set org.gnome.shell favorite-apps "['nemo.desktop', 'google-chrome.desktop', 'firefox.desktop', 'sublime_text.desktop', 'terminator.desktop', 'spotify.desktop']"

# Enable alternatetab and user-theme extensions
gsettings set org.gnome.shell enabled-extensions "['user-theme@gnome-shell-extensions.gcampax.github.com', 'alternate-tab@gnome-shell-extensions.gcampax.github.com']"

# Setting up Gnome workspaces default
gsettings set org.gnome.desktop.wm.preferences num-workspaces 1
gsettings set org.gnome.shell.overrides dynamic-workspaces false

# GTK theme
echo "gsettings gtk-theme 'Flat-Remix-GTK'..." && \
curl -s https://raw.githubusercontent.com/eliseuegewarth/flat-remix-gtk/master/install.sh | bash

# Icon theme
echo "gsettings icon-theme 'Flat-Remix-Dark'..." && \
curl -s https://raw.githubusercontent.com/eliseuegewarth/flat-remix/master/install.sh | bash

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
