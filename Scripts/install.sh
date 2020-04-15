#! /bin/bash

# This is a script with the main installation menu.
# Is to prepare the server for ISPconfig
#
# Author: Renato Opazo Salgado
# Date: 2020-04-14

echo "=========================================="
echo ""
echo "So, you want to prepare your server for ISPconfig."
echo ""
echo "v1.00"
echo "=========================================="
echo ""
echo "1)	Update and Upgrade the Server."
echo "2)	Install ufw, nano, vim-nox and Expect. And the system will reboot"
echo "3)	Enable ufw and allow SSH traffic."
echo " "
echo " "
echo "4)	Install Apache2 and allow HTTP and HTTPS traffic."
echo "		MariaDB and PHP will be also installed."
echo "5)	Install WordPress."
echo " "
echo "6)	Install Nginx and allow HTTP and HTTPS traffic."
echo "7)	Add a Nginx webpage in external server with load balancer."
echo "8)	Add a Nginx webpage in this server"
echo " 		"
echo "9)	Install Node.js and template."
echo "	"
echo "[CTRL] + [C])	Just Exit"
echo ""
echo "=========================================="
echo "Choose one number from above"
read varNr

if [ "$varNr" -eq 1 ]
then
	sudo apt update
	sudo apt -qy upgrade
	echo " "
	echo " "
	echo "Done!! "
	echo " "
	echo " "
	./Scripts/install.sh


elif [ "$varNr" -eq 2 ]
then
	ufw_nano_man
	sudo apt-get -yq install expect
	sudo apt -yq install pwgen
	echo " "
	echo " "
	echo "Done!! "
	echo " "
	echo " "
	echo " "
	echo " "
	echo " "
	echo "Sorry must reboot "
	echo " "
	echo " "
	echo " "
	echo " "
	sudo reboot

elif [ "$varNr" -eq 3 ]
then
	sudo ufw allow ssh
	sudo ufw enable
	echo " "
	echo " "
	echo "Done!! "
	echo " "
	echo " "
	./Scripts/install.sh

elif [ "$varNr" -eq 4 ]
then
	apache_php_inst
	echo " "
	echo " "
	echo "Done!! "
	echo " "
	echo " "
	./Scripts/install.sh

elif [ "$varNr" -eq 5 ]
then
	wp_inst
	echo " "
	echo " "
	echo "Done!! "
	echo " "
	echo " "

elif [ "$varNr" -eq 6 ]
then
	nginx_inst
	echo " "
	echo " "
	echo "Done!! "
	echo " "
	echo " "

elif [ "$varNr" -eq 7 ]
then
	nginx_load_balancer
	echo " "
	echo " "
	echo "Done!! "
	echo " "
	echo " "


elif [ "$varNr" -eq 8 ]
then
	nginx_local_page
	echo " "
	echo " "
	echo "Done!! "
	echo " "
	echo " "


elif [ "$varNr" -eq 9 ]
then
	nodejs_inst
	echo " "
	echo " "
	echo "Done!! "
	echo " "
	echo " "


else
	echo "Okey, Good Bye"
	exit
fi
