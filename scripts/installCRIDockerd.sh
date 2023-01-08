#!/bin/bash

VER="0.3.0"

install_linux() {
   ARCH=$1
   if [ -f /usr/bin/cri-dockerd ];then
      echo "cri-dockerd is Already intalled"
      cri-dockerd --version
   else
      echo "Installing cri-dockerd..."
      wget https://github.com/Mirantis/cri-dockerd/releases/download/v${VER}/cri-dockerd-${VER}.amd64.tgz -P /tmp
      #wget https://github.com/Mirantis/cri-dockerd/releases/download/${VER}/cri-dockerd-${VER}-linux-${ARCH}.tar.gz -P /tmp
      tar -xzvf /tmp/cri-dockerd-${VER}.${ARCH}.tgz -C /tmp
      #tar -xzvf /tmp/cri-dockerd-${VER}-linux-${ARCH}.tar.gz -C /tmp
      mv /tmp/cri-dockerd/cri-dockerd /usr/bin/
      chmod 755 /usr/bin/cri-dockerd
   fi

   if [ -f /etc/systemd/system/cri-docker.service ] && [ -f /etc/systemd/system/cri-docker.socket ];then
      echo "system services are already configured skipping...."
   else
      wget https://raw.githubusercontent.com/Mirantis/cri-dockerd/master/packaging/systemd/cri-docker.service -P /tmp
      wget https://raw.githubusercontent.com/Mirantis/cri-dockerd/master/packaging/systemd/cri-docker.socket -P /tmp
      mv /tmp/cri-docker.socket /tmp/cri-docker.service /lib/systemd/system/
      systemctl enable cri-docker.service
      systemctl enable cri-docker.socket
      systemctl start cri-docker.service
   fi
}
################ MAIN ###################

if [ -f /etc/os-release ];then
   osname=`grep ID /etc/os-release | egrep -v 'VERSION|LIKE|VARIANT' | cut -d'=' -f2 | sed -e 's/"//' -e 's/"//'`
   echo $osname
   if [ $osname == "ubuntu" ];then
      arch=`dpkg --print-architecture`
      install_linux "$arch"
   elif [ $osname == "amzn" ];then
      arch=amd64  
      install_linux "$arch"
   elif [ $osname == "centos" ];then
      arch=amd64
      install_linux "$arch"
   fi
else
   echo "can not locate /etc/os-release - unable find the osname"
   exit 8
fi
exit 0
