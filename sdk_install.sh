#!/bin/bash

export ANDROID_SDK_FILE='android-sdk_r24.4.1-linux.tgz'
export ANDROID_SDK_URL="http://dl.google.com/android/$ANDROID_SDK_FILE"
sudo dpkg --add-architecture i386 && \
    sudo apt-get update -q && \
    sudo apt-get install -qy --no-install-recommends libstdc++6:i386 libgcc1:i386 zlib1g:i386 libncurses5:i386

export ANDROID_HOME='/usr/local/android-sdk-linux'
echo "export ANDROID_HOME='/usr/local/android-sdk-linux'" >> .bash_env
cd /usr/local && \
    sudo wget $ANDROID_SDK_URL && \
    sudo tar -xzf $ANDROID_SDK_FILE && \
    export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools && \
    sudo chgrp -R users $ANDROID_HOME && \
    sudo chmod -R 0775 $ANDROID_HOME && \
sudo rm $ANDROID_SDK_FILE

cd ~/workspace/my_aliases/

echo 'export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$ANDROID_HOME/build-tools/23.0.1' >> .bash_env;
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$ANDROID_HOME/build-tools/23.0.1

android update sdk --no-ui --force --all --filter platform-tools,android-23,build-tools-23.0.1,extra-android-support,extra-android-m2repository,sys-img-x86_64-android-23,extra-google-m2repository
