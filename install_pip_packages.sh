#!/bin/bash
echo "pip install..." && \
sudo apt -qq -y install python3-pip && \
sudo -H pip3 install --upgrade pip && \
sudo -H pip3 install --upgrade setuptools && \
sudo -H pip3 install --use-feature=2020-resolver virtualenv virtualenvwrapper ipython ipdb && exit 0 || exit 1;
