#!/bin/sh
brmodelo_path="/opt/brmodelo"
sudo rm -rf ${brmodelo_path}/ && sudo mkdir -p ${brmodelo_path}/
sudo chmod 777 ${brmodelo_path}
sudo wget http://www.sis4.com/brModelo/brModelo.jar -O ${brmodelo_path}/brModelo.jar
sudo wget https://github.com/chcandido/brModelo/raw/master/src/imagens/icone.png -O ${brmodelo_path}/brmodelo.png

brmodelo_app_file="${HOME}/.local/share/applications/brmodelo.desktop"
sudo touch "${brmodelo_path}/brmodelo.sh"
echo "(cd ${brmodelo_path}/ && java -jar brModelo.jar)&" | sudo tee "${brmodelo_path}/brmodelo.sh"
sudo chmod +x "${brmodelo_path}/brmodelo.sh"

sudo echo "[Desktop Entry]" > ${brmodelo_app_file}
sudo echo "Encoding=UTF-8"  >> ${brmodelo_app_file}
sudo echo "Version=3.2"  >> ${brmodelo_app_file}
sudo echo "Terminal=false"  >> ${brmodelo_app_file}
sudo echo "Comment=BRModelo 3.2"  >> ${brmodelo_app_file}
sudo echo "Name=BRModelo"  >> ${brmodelo_app_file}
sudo echo "Exec=${brmodelo_path}/brmodelo.sh"  >> ${brmodelo_app_file}
sudo echo "Icon=${brmodelo_path}/brmodelo.png"  >> ${brmodelo_app_file}
sudo echo "StartupWMClass=brmodelo"  >> ${brmodelo_app_file}
sudo echo "Type=Application"  >> ${brmodelo_app_file}
sudo echo "Categories=Modeling;"  >> ${brmodelo_app_file}
sudo echo "MimeType=x-scheme-handler/tg;"  >> ${brmodelo_app_file}
sudo echo "X-Desktop-File-Install-Version=0.22"  >> ${brmodelo_app_file}

echo "Finished Setup..."