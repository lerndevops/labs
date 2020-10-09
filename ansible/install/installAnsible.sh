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
  echo "No ansible installation found -- proceeding with ansible installation..."
  sudo apt-get update
  sudo apt-get install -y software-properties-common
  sudo apt-add-repository --yes --update ppa:ansible/ansible
  sudo apt-get install -y ansible
  echo "`ansible --version | head -1` installed Successfully"
  
elif [ $osname == "amzn" ]; then

  clear
  echo "No ansible installation found -- proceeding with ansible installation..."
  sudo yum install -y epel-release
  sudo yum install -y ansible  
  echo "`ansible --version | head -1` installed Successfully"

elif [ $1 == "centos" ];then

  clear
  echo "No ansible installation found -- proceeding with ansible installation..."
  sudo yum install -y epel-release
  sudo yum install -y ansible  
  echo "`ansible --version | head -1` installed Successfully"
fi

exit 0
