#!/bin/bash

prepare_node() {

   #### Install Kubernetes latest components
    which docker
    if [ $? -eq 0 ];then
       echo "docker is already installed no action required.."
       sudo systemctl restart docker
    else
       echo "docker is not installed.. continue to install"
       wget https://raw.githubusercontent.com/lerndevops/labs/master/scripts/installDocker.sh -P /tmp
       bash /tmp/installDocker.sh
    fi 
    which kubectl
    if [ $? -eq 0 ];then
       echo "kubectl is already installed no action required.."
    else
       echo "kubectl is not installed.. continue to install"
       wget https://raw.githubusercontent.com/lerndevops/labs/master/scripts/installKubectl.sh -P /tmp
       bash /tmp/installKubectl.sh
    fi
    which kind
    if [ $? -eq 0 ];then
       echo "kind is already installed no action required.."
    else
       echo "kind is not installed.. continue to install"
       curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.14.0/kind-linux-amd64
       chmod +x ./kind
       sudo mv ./kind /usr/local/bin/kind
    fi
  
}
create_cluster() {
    wget https://raw.githubusercontent.com/lerndevops/labs/master/scripts/configs/kind-k8s-setup-config.yaml -P /tmp
    kind create cluster --config /tmp/kind-k8s-setup-config.yaml
    kubectl get nodes -o wide
}

################ MAIN ###################

if [ -f /etc/os-release ];then
   osname=`grep ID /etc/os-release | egrep -v 'VERSION|LIKE|VARIANT|PLATFORM' | cut -d'=' -f2 | sed -e 's/"//' -e 's/"//'`
   echo $osname
   if [ $osname == "ubuntu" ];then
       prepare_node
       create_cluster
   elif [ $osname == "amzn" ];then
       prepare_node
       create_cluster
   elif [ $osname == "centos" ];then
       prepare_node
       create_cluster
  fi
else
   echo "can not locate /etc/os-release - unable find the osname"
   exit 8
fi
exit 0
