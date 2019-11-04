#!/bin/bash
basedirname="$(dirname "$0")"
cd $basedirname

if [[ $1 = *"--user"* ]]; then
    brmodelo_path="$HOME/.local/share/brmodelo"
    brmodelo_app_file="${HOME}/.local/share/applications/brmodelo.desktop"
elif [[ $1 = *"--all"* ]]; then
    brmodelo_path="/opt/brmodelo"
    brmodelo_app_file="usr/share/applications/brmodelo.desktop"
else
    echo "Run with argument '--user' or '--all'."
    exit 0;
fi

tmp_desktop_file="/tmp/brmodelo.desktop"

echo "[Desktop Entry]" > $tmp_desktop_file
echo "Encoding=UTF-8"  >> $tmp_desktop_file
echo "Version=3.2"  >> $tmp_desktop_file
echo "Terminal=false"  >> $tmp_desktop_file
echo "Comment=BRModelo 3.2"  >> $tmp_desktop_file
echo "Name=BRModelo"  >> $tmp_desktop_file
echo "Exec=${brmodelo_path}/brmodelo.sh"  >> $tmp_desktop_file
echo "Icon=${brmodelo_path}/brmodelo.png"  >> $tmp_desktop_file
echo "StartupWMClass=brmodelo"  >> $tmp_desktop_file
echo "Type=Application"  >> $tmp_desktop_file
echo "Categories=Modeling;"  >> $tmp_desktop_file
echo "MimeType=x-scheme-handler/tg;"  >> $tmp_desktop_file
echo "X-Desktop-File-Install-Version=0.22"  >> $tmp_desktop_file

cp $tmp_desktop_file $brmodelo_app_file
