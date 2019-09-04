#!/bin/bash
echo "pip install..." && \
sudo apt -qq -y install python-pip && \
sudo -H pip install --upgrade pip && \
sudo -H pip install --upgrade setuptools && \
sudo -H pip install virtualenv virtualenvwrapper ipython ipdb && exit 0 || exit 1;
