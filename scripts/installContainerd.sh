#!/bin/bash

install_ubuntu() {
    ## Remove any pre installed containerd packages:
    which containerd
    if [ $? -eq 0 ];then
       systemctl stop containerd.service
       apt-get remove -y containerd
       apt-get purge -y containerd
       apt -y autoremove
       if [ -f /etc/modules-load.d/containerd.conf ];then
          rm /etc/modules-load.d/containerd.conf
       fi
       if [ -f /etc/sysctl.d/99-kubernetes-cri.conf ];then
          rm /etc/sysctl.d/99-kubernetes-cri.conf
       fi
       if [ -f /etc/containerd/config.toml ];then
          rm /etc/containerd/config.toml
       fi
    else
       echo "containerd is not installed.. continue to install"
    fi

    ## Install using the repository:
    apt-get update
    apt-get install -y containerd

    if [ $? -eq 0 ];then
        echo "containerd is successfully installed"
        configure_contd
    else
      echo "issue with containerd installation - process abort"
      exit 1
    fi
    exit 0
}

install_centos() {

    which containerd
    if [ $? -eq 0 ];then
       yum remove -y containerd.io
       yum clean
    else
       echo "containerd is not installed... continue to install"
    fi
    yum install -y yum-utils   ## device-mapper-persistent-data lvm2
    yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    yum install containerd.io -y
    if [ $? -eq 0 ];then
       echo "containerd is successfully installed"
       systemctl restart containerd ; clear
       configure_contd
    else
       echo "issue with containerd installation - process abort"
       exit 1
    fi
}

configure_contd() {

if [ -f /etc/modules-load.d/containerd.conf ];then
echo "/etc/modules-load.d/containerd.conf exist, skipping.."
else
cat <<EOF | sudo tee /etc/modules-load.d/containerd.conf
overlay
br_netfilter
EOF
fi

if [ -f /etc/sysctl.d/99-kubernetes-cri.conf ];then
echo "/etc/sysctl.d/99-kubernetes-cri.conf exists, skipping.."
else
cat <<EOF | sudo tee /etc/sysctl.d/99-kubernetes-cri.conf
net.bridge.bridge-nf-call-iptables = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward = 1
EOF
fi

sudo modprobe overlay
sudo modprobe br_netfilter

#reload kernel config 
sudo sysctl --system
# generate default containerd config 
if [ -d /etc/containerd ];then
   if [ -f /etc/containerd/config.toml ];then
      echo "containerd default config exist, skipping.."
   else
      containerd config default | sudo tee /etc/containerd/config.toml
      sed -i "s/SystemdCgroup = false/SystemdCgroup = true/g" /etc/containerd/config.toml
      systemctl restart containerd
   fi
else
   mkdir -p /etc/containerd
   containerd config default | sudo tee /etc/containerd/config.toml
   sed -i "s/SystemdCgroup = false/SystemdCgroup = true/g" /etc/containerd/config.toml
   systemctl restart containerd
fi
}
################ MAIN ###################

if [ -f /etc/os-release ];then
   osname=`grep ID /etc/os-release | egrep -v 'VERSION|LIKE|VARIANT|PLATFORM' | cut -d'=' -f2 | sed -e 's/"//' -e 's/"//'`
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
