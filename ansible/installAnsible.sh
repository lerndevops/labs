#!/bin/bash

which ansible

if [ $? -eq "0" ];then
   echo "`ansible --version | head -1` - is already installed"
   exit
else
  clear
  echo "No ansible installation found -- proceeding with ansible installation..."
  sudo apt-get update
  sudo apt-get install -y software-properties-common
  sudo apt-add-repository --yes --update ppa:ansible/ansible
  sudo apt-get install -y ansible
  echo "`ansible --version | head -1` installed Successfully"
fi
exit
