#!/bin/bash

uninstall_ubuntu() {
    ## Remove any pre installed docker packages:
    which docker
    if [ $? -eq 0 ];then
       sudo systemctl stop docker.socket
       sudo systemctl stop docker.service
       sudo apt-get remove -y docker-ce docker-engine docker.io containerd runc
       sudo apt-get purge -y docker-ce docker-ce-cli containerd.io
       sudo apt -y autoremove
       cd /var/lib
       rm -rf docker
    else
       echo "docker is not installed.."
    fi
    exit 0
}

uninstall_centos() {

    which docker
    if [ $? -eq 0 ];then
       sudo yum remove docker-client-latest docker-latest docker-latest-logrotate docker-logrotate docker-engine
       cd /var/lib
       rm -rf docker
       yum clean
    else
       echo "docker is not installed... continue to install"
    fi
}
################ MAIN ###################

if [ -f /etc/os-release ];then
   osname=`grep ID /etc/os-release | egrep -v 'VERSION|LIKE|VARIANT|PLATFORM' | cut -d'=' -f2 | sed -e 's/"//' -e 's/"//'`
   echo $osname
   if [ $osname == "ubuntu" ];then
       uninstall_ubuntu
   elif [ $osname == "amzn" ];then
       uninstall_centos
   elif [ $osname == "centos" ];then
       uninstall_centos
  fi
else
   echo "can not locate /etc/os-release - unable find the osname"
   exit 8
fi
exit 0
