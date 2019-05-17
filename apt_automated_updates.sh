complement=""
if [ ! -z $1 ]
then
	complement=" && $1";
fi
sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean $complement && exit 0 || exit 1


