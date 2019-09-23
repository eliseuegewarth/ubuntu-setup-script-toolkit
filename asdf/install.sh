#!/bin/bash

if [[ -z "$(ls -a ${HOME} | grep '.asdf')" ]]; then
	git clone https://github.com/asdf-vm/asdf.git ${HOME}/.asdf
	cd ${HOME}/.asdf
	git checkout "$(git describe --abbrev=0 --tags)"
fi

if [[ -z "$(cat ${HOME}/.bashrc | grep '.asdf/asdf.sh')" ]]; then
	echo "YES!"
	echo -e '\n. $HOME/.asdf/asdf.sh' >> ${HOME}/.bashrc
	echo -e '\n. $HOME/.asdf/completions/asdf.bash' >> ${HOME}/.bashrc
fi

sudo apt install \
  automake autoconf libreadline-dev \
  libncurses-dev libssl-dev libyaml-dev \
  libxslt-dev libffi-dev libtool unixodbc-dev \
  unzip curl -y
