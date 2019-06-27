#!/bin/bash

## Remove any pre installed docker packages : 
sudo apt-get remove -y docker docker-engine docker.io docker-ce
cd /var/lib
rm -r docker
rm `which docker-compose`
rm `which docker-machine`
## Install using the repository:

sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
## Add Dockers official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

## Install Docker latest
sudo apt-get update ; clear

echo "starting the installation of docker-ce ...."
echo "Available Version for Install"
echo " "
apt-cache madison docker-ce | awk '{print $3}'
echo " "
read -p 'Enter Required Version: ' version

sudo apt-get install -y docker-ce=$version
sudo service docker start

echo "starting the installation of docker-compose ...."
echo " "
sudo curl -L https://github.com/docker/compose/releases/download/1.23.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
echo " "
echo "Validating the versions Installed"

echo "`docker -v` - is installed Successfully"
echo "`docker-compose -v` - is installed Successfully"

exit 0
