#!/bin/bash
brmodelo_path="/opt/brmodelo"
rm -rf ${brmodelo_path}/ && mkdir -p ${brmodelo_path}/
chmod 777 ${brmodelo_path}
wget http://www.sis4.com/brModelo/brModelo.jar -O ${brmodelo_path}/brModelo.jar
wget https://github.com/chcandido/brModelo/raw/master/src/imagens/icone.png -O ${brmodelo_path}/brmodelo.png

brmodelo_app_file="${HOME}/.local/share/applications/brmodelo.desktop"
touch "${brmodelo_path}/brmodelo.sh"
echo "(cd ${brmodelo_path}/ && java -jar brModelo.jar)&" | tee "${brmodelo_path}/brmodelo.sh"
chmod +x "${brmodelo_path}/brmodelo.sh"

echo "[Desktop Entry]" > ${brmodelo_app_file}
echo "Encoding=UTF-8"  >> ${brmodelo_app_file}
echo "Version=3.2"  >> ${brmodelo_app_file}
echo "Terminal=false"  >> ${brmodelo_app_file}
echo "Comment=BRModelo 3.2"  >> ${brmodelo_app_file}
echo "Name=BRModelo"  >> ${brmodelo_app_file}
echo "Exec=${brmodelo_path}/brmodelo.sh"  >> ${brmodelo_app_file}
echo "Icon=${brmodelo_path}/brmodelo.png"  >> ${brmodelo_app_file}
echo "StartupWMClass=brmodelo"  >> ${brmodelo_app_file}
echo "Type=Application"  >> ${brmodelo_app_file}
echo "Categories=Modeling;"  >> ${brmodelo_app_file}
echo "MimeType=x-scheme-handler/tg;"  >> ${brmodelo_app_file}
echo "X-Desktop-File-Install-Version=0.22"  >> ${brmodelo_app_file}

echo "Finished Setup..."
