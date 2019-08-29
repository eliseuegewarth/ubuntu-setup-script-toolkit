#!/bin/bash
echo "Install wps-office..." && \
cd /tmp/ && \
echo "Downloading wps-office.deb ..." && \
wget http://kdl.cc.ksosoft.com/wps-community/download/6757/wps-office_10.1.0.6757_amd64.deb -O wps-office.deb && \
echo "Downloading wps-office-fonts.deb ..." && \
wget http://kdl.cc.ksosoft.com/wps-community/download/fonts/wps-office-fonts_1.0_all.deb -O web-office-fonts.deb && \
echo "Dpkg install wps-office..." && \
sudo dpkg -i wps-office*.deb && exit 0 || exit 1;
