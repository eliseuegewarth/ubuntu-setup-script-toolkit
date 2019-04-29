#!/bin/bash
sudo apt -qq -y install zsh && \
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)" && \
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="avit"/g' ~/.zshrc && \
# General bash setup
if [ -z "$(cat ${HOME}/.zshrc | grep bash_env)" ]; then
    echo "Adicionando bash_env em zshrc ..." && \
    echo -e "\nif [ -f ${HOME}/.bash_env ]; then\n    . ${HOME}/.bash_env\nfi" >> ${HOME}/.zshrc;
fi

if [ -z "$(cat ${HOME}/.zshrc | grep bash_aliases)" ]; then
    echo "Adicionando bash_aliases em zshrc ..." && \
    echo -e "\nif [ -f ${HOME}/.bash_aliases ]; then\n    . ${HOME}/.bash_aliases\nfi" >> ${HOME}/.zshrc;
fi

sudo sed -i 's|${HOME}:/usr/bin/bash|${HOME}:/usr/bin/zsh|g' /etc/passwd
