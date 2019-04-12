sudo apt -qq -y install zsh && \
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)" && \
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="avit"/g' ~/.zshrc && \
sudo sed -i 's|${HOME}:/usr/bin/bash|${HOME}:/usr/bin/zsh|g' /etc/passwd
