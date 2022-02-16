#!/bin/bash

DC_VERSION=1.29.2
echo "starting the installation of docker-compose ...."
echo " "
sudo curl -L https://github.com/docker/compose/releases/download/$DC_VERSION/docker-compose-`uname -s`-`uname -m` -o /usr/bin/docker-compose
sudo chmod +x /usr/bin/docker-compose
echo " "
echo "Validating the versions Installed"
echo "`docker-compose -v` - is installed Successfully"
