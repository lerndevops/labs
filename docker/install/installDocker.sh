#!/bin/bash

install_ubuntu() {
    ## Remove any pre installed docker packages :
    sudo service docker stop 
    sudo apt-get remove -y docker-ce docker-engine docker.io containerd runc
    sudo apt-get purge -y docker-ce docker-ce-cli containerd.io
    sudo apt -y autoremove
    cd /var/lib
    rm -r docker
    rm `which docker-compose`
    rm `which docker-machine`
    ## Install using the repository:
    sudo apt-get update
    sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
    ## Add Dockers official GPG key & stable repo
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    ## Install Docker latest
    sudo apt-get update ; clear
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io
    sudo service docker start
    ## curl -fsSL https://get.docker.com -o get-docker.sh
    ## sudo sh get-docker.sh
    echo "starting the installation of docker-compose ...."
    echo " "
    sudo curl -L https://github.com/docker/compose/releases/download/1.23.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    echo " "
    echo "Validating the versions Installed"
    echo "`docker -v` - is installed Successfully"
    echo "`docker-compose -v` - is installed Successfully"
    exit 0
}

install_centos() {

    sudo yum remove docker-client-latest docker-latest docker-latest-logrotate docker-logrotate docker-engine
    sudo yum install -y yum-utils device-mapper-persistent-data lvm2
    sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    sudo yum install docker-ce docker-ce-cli containerd.io

}
################ MAIN ###################

if [ -f /etc/os-release ];then
   osname=`grep ID /etc/os-release | egrep -v 'VERSION|LIKE|VARIANT' | cut -d'=' -f2 | sed -e 's/"//' -e 's/"//'`
   echo $osname
   if [ $osname == "ubuntu" ];then
       install_ubuntu
   elif [ $osname == "amzn" ];then
       install_centos
   elif [ $osname == "centos" ];then
       install_centos
  fi
else
   echo "can not locate /etc/os-release - unable find the osname"
   exit 8
fi
exit 0

