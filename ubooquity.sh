#!/bin/bash
# Compatible Debian 9 Stretch
# GPL
#
# Syntaxe: # su - -c "./debian-postinstall.sh"
# Syntaxe: or # sudo ./debian-postinstall.sh
VERSION="0.1"

# Test que le script est lance en root
#-----------------------------------
if [ $EUID -ne 0 ]; then
  echo -e "\nLe script doit être lancé avec l'utilisateur root: # sudo $0" 1>&2
  exit 1
fi


# Mise a jour de la liste des depots
#-----------------------------------

# Update 
echo -e "\n### Mise a jour de la liste des depots\n"
apt update

# Upgrade
echo -e "\n### Mise a jour du systeme\n"
apt -y upgrade


# Prerequies
#-----------------------------------

apt-get -y ca-certificates software-properties-common python-software-properties screen nano unzip 


# Oracle Java Installation
#-----------------------------------

echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" > /etc/apt/sources.list.d/webupd8team-java.list
echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" > /etc/apt/sources.list.d/webupd8team-java.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
apt-get update
apt-get install oracle-java8-installer -y 


# Files
#-----------------------------------

if [ ! -d "/home/tv" ];then
	echo "Création du dosser Ubooquity";
	mkdir /home/tv; 
	cd /home/tv;
		mkdir ubooquity;
		chmod u+x ubooquity;
		cd ubooquity
fi	

# Download Ubooquity	
wget -O ubooquity.zip http://vaemendis.net/ubooquity/service/download.php
unzip -o ubooquity.zip && rm ubooquity.zip

# Starting Ubooquity
iptables -A INPUT -p tcp -m tcp --dport 4048 -j ACCEPT
screen java -jar -Djava.awt.headless=true /home/tv/ubooquity/Ubooquity.jar -webadmin -headless -port 4048

echo 'Enter one line at a time'
echo 'Press CTRL A+D to finish'
cat >test.out

# Themes
cd /tmp

wget -O  "Dark Theme - Ubooquity.zip" "http://bit.ly/1FvhCZZ" && unzip Dark*.zip -d /home/tv/ubooquity/themes/DarkThemes 
wget -O http://vaemendis.net/ubooquity/downloads/themes/modern-1.7.0.zip && unzip modern-1.7.0.zip -d /home/tv/ubooquity/themes/
wget -O TheGray.zip "https://docs.google.com/uc?id=0B2UyNSVyI_nRbzNZak9pUFZQQ2M&export=download" && unzip TheGray.zip -d /home/tv/ubooquity/themes/
