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
  sudo apt-get install -y software-properties-common
  sudo apt-add-repository --yes --update ppa:git-core/ppa
  sudo apt-get update
  sudo apt-get install -y git
  echo "`git --version | head -1` installed Successfully"
  
elif [ $osname == "amzn" ]; then

  clear
  sudo yum install -y epel-release
  sudo yum update
  sudo yum install -y git  
  echo "`git --version | head -1` installed Successfully"

elif [ $osname == "centos" ];then

  clear
  sudo yum install -y epel-release
  sudo yum update
  sudo yum install -y git
  echo "`git --version | head -1` installed Successfully"
fi

exit 0
