#! /bin/bash

# This script will collect all basic functions.
#
# Author: Renato Opazo Salgado
# Date: 2020-04-15

export $(egrep -v '^#' ./Scripts/.env | xargs)

function ufw_nano_man
{
	if which ufw > /dev/null; then
		echo "UFW Firewall is allready installed...		skipping"

	else
		apt -qy install ufw
	fi
	if which nano > /dev/null; then
		echo "Nano editor is allready installed...		skipping"

	else
		apt -qy install nano vim-nox

	fi
	if which man > /dev/null; then
		echo "Man manuall is allready installed...		skipping"

	else
		apt -qy install man
	fi

	echo "You have this versions in your server:"
	echo ""
	ufw version
	nano -V
	man -V
}

function add_hosts_to_hosts_file {
  pattern="/The following/"
  sed_i="i\\"
  file_url="/etc/hosts"
  sed -i "$pattern$sed_i$WEB_IP   $WEB_DOMAIN $WEB_HOSTNAME" $file_url
  sed -i "$pattern$sed_i$MAIL_IP   $MAIL_DOMAIN $MAIL_HOSTNAME" $file_url
  sed -i "$pattern$sed_i$DB_IP   $DB_DOMAIN $DB_HOSTNAME" $file_url
  sed -i "$pattern$sed_i$NS1_IP   $NS1_DOMAIN $NS1_HOSTNAME" $file_url
  sed -i "$pattern$sed_i$NS2_IP   $NS2_DOMAIN $NS2_HOSTNAME\n" $file_url
}

function change_hostname_file
{
  if [ -"$THIS_SERVER_IS" == "$WEB_HOSTNAME" ]; then
    hostnamectl set-hostname "$WEB_DOMAIN"

  elif [ -"$THIS_SERVER_IS" == "$MAIL_HOSTNAME" ]; then
    hostnamectl set-hostname "$MAIL_HOSTNAME"
    echo "$MAIL_DOMAIN" > /etc/mailname

  elif [ -"$THIS_SERVER_IS" == "$DB_HOSTNAME" ]; then
    hostnamectl set-hostname "$DB_HOSTNAME"

  elif [ -"$THIS_SERVER_IS" == "$NS1_HOSTNAME" ]; then
    hostnamectl set-hostname "$NS1_HOSTNAME"

  elif [ -"$THIS_SERVER_IS" == "$NS2_HOSTNAME" ]; then
    hostnamectl set-hostname "$NS2_HOSTNAME"
  fi

}

function create_swap {
  cd /var
  touch swap.img
  chmod 600 swap.img
  dd if=/dev/zero of=/var/swap.img bs=1024k count="$SWAP_CUSTOM_SIZE"
  mkswap /var/swap.img
  swapon /var/swap.img
  echo "/var/swap.img    none    swap    sw    0    0" >> /etc/fstab
  cd ~/
  sysctl -w vm.swappiness=30
}