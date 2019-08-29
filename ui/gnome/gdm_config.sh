#!/bin/bash
ORIGIN="$PWD"
if [ "18.04" == "$(lsb_release -rs)" ]; then
	echo "Preparing..."
else
	echo "This script was prepared for GNOME Shell 3.28... Are you sure to continue? [Y/n]"
	read answ
	if [[ "$answ" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
		echo "Preparing...";
	else
		exit 0;
	fi
fi
cd /tmp;
folder_name="Ocean-blue-GDM3"
git clone https://github.com/taeven/${folder_name};
cd $folder_name;
if [ -z "$GDM_BG_IMAGE" ]; then
	GDM_BG_IMAGE="bg-boat.jpg"
elif [ -z "$(echo $GDM_BG_IMAGE | grep '.jpg')" ]; then
	GDM_BG_IMAGE="bg-boat.jpg"
fi
exit 0;
if [ "$GDM_BG_IMAGE" == "bg-boat.jpg" ]; then
	echo "Using default theme image..."
else
	sed -i 's/bg-boat.jpg/$GDM_BG_IMAGE/g' ubuntu.css
fi
# cp $GDM_BG_IMAGE /usr/share/backgrounds/
# cp /usr/share/gnome-shell/theme/ubuntu.css /usr/share/gnome-shell/theme/ubuntu.bk
# cp ubuntu.css /usr/share/gnome-shell/theme/
echo "";