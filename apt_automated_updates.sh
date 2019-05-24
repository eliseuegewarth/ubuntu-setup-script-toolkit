complement="echo 'Finished'";
if [ -z $1 ]
then
	echo "nothing to do";
else
	param_number_limit=5;
	if [ $# -gt $param_number_limit ]
	then
		echo "The limit of parameter is $param_number_limit."
		exit 0;
	else
		complement="$*";
	fi
fi
sudo apt update && sudo apt upgrade -y && sudo apt autoremove -y && sudo apt autoclean $(${complement}) && exit 0 || exit 1
