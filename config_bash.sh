#!/bin/bash
# General bash setup
if [ -z "$(cat ${HOME}/.bashrc | grep bash_env)" ]; then
    echo "Adicionando bash_env em bashrc ..." && \
    echo -e "\nif [ -f ${HOME}/.bash_env ]; then\n    . ${HOME}/.bash_env\nfi" >> ${HOME}/.bashrc;
fi

echo "Criando links simbolicos bash_aliases e bash_env ..." && \
ln -sf ${PWD}/.bash_aliases ${HOME}/.bash_aliases > /dev/null && \
ln -sf ${PWD}/.bash_env ${HOME}/.bash_env > /dev/null;
