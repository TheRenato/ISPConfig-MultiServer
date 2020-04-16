#! /bin/bash

# This is a script with the main installation menu.
# Is to prepare the server for ISPConfig
#
# Author: Renato Opazo Salgado
# Date 2020-04-15
source ./Scripts/basic_functions.sh

# This checks are from the servisys ispconfig_setup installation file
if [[ "$#" -ne 0 ]]; then
	echo -e "Usage: sudo $0" >&2
	exit 1
fi

# Check if user is root
if [[ $(id -u) -ne 0 ]]; then # $EUID
	echo -e "Error: This script must be run as root, please run this script again with the root user or sudo." >&2
	exit 1
fi

# Check if on Linux
if ! echo "$OSTYPE" | grep -iq "linux"; then
	echo -e "Error: This script must be run on Linux." >&2
	exit 1
fi

echo "=========================================="
echo ""
echo "So, you want to prepare your server for ISPConfig"
echo ""
echo "v1.01"
echo "=========================================="
echo ""
echo "1)	First run Update and Upgrade the Server."
echo "  	And check if needed to install ufw, nano, vim-nox."
echo "2)	Enable ufw and allow only SSH traffic."
echo " "
echo "3)	Have you edited the .env file? No?"
echo "  	Then lets do it now. We will use Nano"
echo " "
echo "4)	Lets add your .env file data to the hosts and hostname file."
echo " "
echo "5)  Now we will create the swap file. "
echo "    OBSERVE! This will NOT check if you have SWAPON or not."
echo " "
echo "6)	Let's do the steps 1, 2, 4 and 5."
echo "7)	And now the ISPConfig installation script from servisys."
echo "8)	Or use my forked version of the ISPConfig installation script from servisys."
echo " 		"
echo "9)	Reboot"
echo "	"
echo "[CTRL] + [C])	Just Exit"
echo ""
echo "=========================================="
echo "Choose one number from above"
read varNr

if [ "$varNr" -eq 1 ]
then
	apt update
	apt -qy upgrade
	ufw_nano_man
	apt-get -y install ntp ntpdate
	echo " "
	echo " "
	echo "Done!! "
	echo " "
	echo " "
	echo " "
	echo "You should reboot "
	echo " "
	echo " "
	./Scripts/install.sh


elif [ "$varNr" -eq 2 ]
then
	ufw allow ssh
	ufw enable
	echo " "
	echo " "
	echo "Done!! "
	echo " "
	echo " "
	echo " "
	echo " "
	echo " "
	./Scripts/install.sh

elif [ "$varNr" -eq 3 ]
then
	nano ./Scripts/.env
	echo " "
	echo " "
	echo "Done!! "
	echo " "
	echo " "
	./Scripts/install.sh

elif [ "$varNr" -eq 4 ]
then
  add_hosts_to_hosts_file
  change_hostname_file
	echo " "
	echo " "
	echo "Done!! "
	echo " "
	echo " "
	./Scripts/install.sh

elif [ "$varNr" -eq 5 ]
then
	create_swap
	echo " "
	echo " "
	echo "Done!! "
	echo " "
	echo " "

elif [ "$varNr" -eq 6 ]
then
	apt update
	apt -qy upgrade
	ufw_nano_man
	apt-get -y install ntp ntpdate
	ufw allow ssh
	ufw enable
  add_hosts_to_hosts_file
  change_hostname_file
	create_swap
	echo " "
	echo " "
	echo "Done!! "
	echo "You should reboot "
	echo " "
	echo " "
	./Scripts/install.sh

elif [ "$varNr" -eq 7 ]
then
	cd /tmp; wget -O installer.tgz "https://github.com/servisys/ispconfig_setup/tarball/master"; tar zxvf installer.tgz; cd *ispconfig*; sudo bash install.sh
	echo " "
	echo " "
	echo "Done!! "
	echo " "
	echo " "


elif [ "$varNr" -eq 8 ]
then
	cd /tmp; wget -O installer.tgz "https://github.com/TheRenato/ispconfig_setup/tarball/master"; tar zxvf installer.tgz; cd *ispconfig*; sudo bash install.sh
	echo " "
	echo " "
	echo "Done!! "
	echo " "
	echo " "


elif [ "$varNr" -eq 9 ]
then
	echo " "
	echo " "
	echo "We will reboot!! "
	echo "To start the script again write: "
	echo "./Scripts/install.sh"
	echo " "
	echo " "
	reboot


else
	echo "Okey, Good Bye"
	exit
fi
