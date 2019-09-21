#!/bin/bash

which git

if [ $? -eq "0" ];then
   echo "`git --version` - is already installed on `hostname`"
   exit
else
  echo "No git installation found -- proceeding with git installation..."
  sudo apt-get install -y python-software-properties
  sudo apt-get install -y software-properties-common
  sudo apt-get remove -y git git-core
  sudo apt-add-repository --yes ppa:git-core/ppa
  sudo apt-get update
  sudo apt-get install -y git
  echo "`git --version` installed Successfully"
fi
exit
