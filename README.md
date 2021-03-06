# ISPConfig-MultiServer

Some notes and steps for ISPconfig multiserver installation, and some own created scripts to prepare the server for a ISPConfig installation.

You can follow the notes bellow or just download the repo to your server and run the script install.sh.
Don't forget to edit the .env file.

Observe, some function in the script will only work in Debian 10.

#### Script Issues
* hostnamectl set-hostname, will not set.
* The scripts are only tested in Debian 10. 

#### Future feature
* Pre config all 5 server in one run.
* You tell me.

## Do it manually first run on every server:

### All the same:

run this command:

```
nano /etc/hosts
```

And insert this (edit the IP's and domain so it fitts your):
```
95.200.200.101   web1.yourdomain.com web1
95.200.200.102   mail1.yourdomain.com mail1
95.200.200.103   db1.yourdomain.com db1
95.200.200.104   ns1.yourdomain.com ns1
95.200.200.105   ns2.yourdomain.com ns2
```
#### And then:
```
apt-get update
```
```
apt-get -y upgrade
```
```
apt-get -y install ntp ntpdate
```

### Swap file 
source: https://www.digitalocean.com/community/tutorials/how-to-configure-virtual-memory-swap-file-on-a-vps


```
cd /var
```
```
touch swap.img
```
```
chmod 600 swap.img
```
#### Size of swap? 3Gig?
```
dd if=/dev/zero of=/var/swap.img bs=1024k count=3000
```
```
mkswap /var/swap.img
```

#### Enabling and on Boot SwapOn
```
swapon /var/swap.img
```
```
echo "/var/swap.img    none    swap    sw    0    0" >> /etc/fstab
```

#### default swappiness is set to 60%, to high in my oppinion. I will set it to 30%.
```
sysctl -w vm.swappiness=30
```
#### You can check swappiness with this command:
```
sysctl -a | grep vm.swappiness
```
### This is individual for every server (change so it fits your domain):
#### Observe! In Debian 10 it should be ```hostnamectl set-hostname``` instead editing directly to ```/etc/hostname``` 
#### web1
Ubuntu:
```
echo web1.yourdomain.com > /etc/hostname
```
Debian:
```
hostnamectl set-hostname web1.yourdomain.com
```

#### mail1
Ubuntu:
```
echo mail1 > /etc/hostname
```
Debian:
```
hostnamectl set-hostname mail1
```
All:
```
echo mail1.yourdomain.com > /etc/mailname
```
#### db1
Ubuntu:
```
echo db1 > /etc/hostname
```

Debian:
```
hostnamectl set-hostname db1
```
#### ns1
Ubuntu:
```
echo ns1 > /etc/hostname
```
Debian:
```
hostnamectl set-hostname ns1
```
#### ns2
Ubuntu:
```
echo ns2 > /etc/hostname
```
Debian:
```
hostnamectl set-hostname ns2
```
#### Maybe reboot
```
reboot
```
### ISPconfig Script

#### You can use the original installation file from servisys:
```
cd /tmp; wget -O installer.tgz "https://github.com/servisys/ispconfig_setup/tarball/master"; tar zxvf installer.tgz; cd *ispconfig*; sudo bash install.sh
```

#### Or the one I forked from servisys with small changes:
```
cd /tmp; wget -O installer.tgz "https://github.com/TheRenato/ispconfig_setup/tarball/master"; tar zxvf installer.tgz; cd *ispconfig*; sudo bash install.sh
```