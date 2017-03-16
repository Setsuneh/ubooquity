#!/usr/bin/env bash
#
# This file is copyright under the latest version of the EUPL.
# Please see LICENSE file for your rights under this license.

# Check if user is root
if [ $(id -u) != "0" ]; then
    echo "Error: You must be root to run this script, please use the root user to install the software."
    exit 1
fi

clear && clear

# Download lastest versions
apt-get update && apt-get dist-upgrade -y
apt-get -y ca-certificates \
	   software-properties-common \
 	   python-software-properties \
	   screen \
	   nano \
	   unzip 

echo ""; set "132" "134"; FONCTXT "$1" "$2"; echo -e "${CBLUE}$TXT1${CEND}${CGREEN}$TXT2${CEND}"; echo ""

# Oracle Java Installation 
echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" > /etc/apt/sources.list.d/webupd8team-java.list
echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" > /etc/apt/sources.list.d/webupd8team-java.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
apt-get update
apt-get install oracle-java8-installer -y 

# Files
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
