#!/bin/bash

# adicional libs for android studio
sudo apt-get -qq -y install libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1 libbz2-1.0:i386

# Instalação Android Studio
wget https://dl.google.com/dl/android/studio/ide-zips/3.1.0.16/android-studio-ide-173.4670197-linux.zip -o /tmp/android-studio.zip && \
unzip /tmp/android-studio.zip
./android-studio/bin/studio.sh
