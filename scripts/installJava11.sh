#!/bin/bash

if [ -f /etc/os-release ];then
   osname=`grep ID /etc/os-release | egrep -v 'VERSION|LIKE|VARIANT' | cut -d'=' -f2 | sed -e 's/"//' -e 's/"//'`
   echo $osname
else
   echo "can not locate /etc/os-release - unable find the osname"
   exit 8
fi

if [ $osname == "ubuntu" ];then

  clear
  sudo add-apt-repository ppa:openjdk-r/ppa
  sudo apt-get update
  sudo apt-get install -y openjdk-11-jdk

elif [ $osname == "amzn" ]; then

  clear
  sudo yum install -y yum-utils
  sudo yum update
  sudo yum install java-11-openjdk-devel

elif [ $osname == "centos" ];then

  clear
  sudo yum install -y yum-utils
  sudo yum update
  sudo yum install java-11-openjdk-devel

fi

exit 0
