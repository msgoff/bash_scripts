#
# Author: JackWhite20
# Description: Script to install Java 8 on ubuntu or debian
#

# No args
if [ $# -eq 0 ]
  then
    echo "Arguments: [debian|ubuntu]"
    exit 1
fi

# Too many args
if [ $# -ge 2 ]
  then
    echo "Arguments: [debian|ubuntu]"
    exit 1
fi

# Debian
if [ "$1" == "debian" ]
then
	echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list
	echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
	apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EEA14886
	apt-get update
	apt-get -y install oracle-java8-installer
fi

# Ubuntu
if [ "$1" == "ubuntu" ]
then
	sudo add-apt-repository ppa:webupd8team/java
	sudo apt-get update
	sudo apt-get -y install oracle-java8-installer
fi
