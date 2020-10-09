#!/bin/bash

#### Remove if a cluster is already running
sudo kubeadm reset -f
#sleep 30

#### Remove any pre installed docker packages  
sudo apt-mark unhold docker-ce docker-ce-cli kubectl kubeadm kubelet
sudo apt-get remove -y docker docker-engine docker.io containerd runc kubeadm kubectl kubelet
cd /var/lib
sudo rm -r docker

#### Install Specific Docker version
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common 
## Add Dockers official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update ; clear
echo "Available Docker Version for Install"
echo " "
apt-cache madison docker-ce | awk '{print $3}'
echo " "
#read -p 'Enter Required Version: ' version
dcever="5:18.09.8~3-0~ubuntu-bionic"
sudo apt-get install -y docker-ce="$dcever" docker-ce-cli=$dcever containerd.io --allow-downgrades
if [ $? -eq 0 ];then
     echo "docker-ce-$dcever is successfully installed"
else
     echo "issue with docker-ce installation - process abort"
     exit 1
fi
sudo service docker start ; clear
echo " "
#### Install Kubernetes latest components
echo "starting the installation of k8s components (kubeadm,kubelet,kubectl) ...."
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-get update ; clear
echo "Available Kubeadm,kubelet,kubectl Versions to install as below"
echo " "
apt-cache madison kubeadm | head | awk '{print $1,$2,$3}'
echo "=================================="
apt-cache madison kubelet | head | awk '{print $1,$2,$3}'
echo "=================================="
apt-cache madison kubectl | head | awk '{print $1,$2,$3}'
echo " "
kubever="1.18.6-00"
echo "Installing v1.17.4-00 Version for kubeadm,kubelet,kubectl"
sudo apt-get install -y kubeadm=$kubever kubelet=$kubever kubectl=$kubever
if [ $? -eq 0 ];then
     echo "kubelet, kubeadm & kubectl with Version $kuberver are successfully installed"
else
     echo "issue in installing kubelet, kubeadm & kubectl - process abort"
     exit 2
fi
sudo apt-mark hold kubelet kubeadm kubectl docker-ce docker-ce-cli
echo " "
