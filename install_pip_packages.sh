#!/bin/bash
echo "pip install..." && \
sudo -H pip install --upgrade pip && \
sudo -H pip install --upgrade setuptools && \
sudo -H pip install virtualenv virtualenvwrapper ipython ipdb && exit 0 || exit 1;
