#!/bin/bash

#### Remove if a cluster is already running
sudo kubeadm reset -f
sleep 30

#### Remove any pre installed docker packages  
sudo apt-mark unhold docker-ce kubectl kubeadm kubelet
sudo apt-get remove -y docker docker-engine docker.io docker-ce kubeadm kubectl kubelet
cd /var/lib
sudo rm -r docker
#### set swap off 
#swapoff -a

#### Install Specific Docker version
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
## Add Dockers official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update ; clear
echo "Available Docker Version for Install"
echo " "
apt-cache madison docker-ce | awk '{print $3}'
echo " "
read -p 'Enter Required Version: ' version
sudo apt-get install -y docker-ce=$version
if [ $? -eq 0 ];then
     echo "docker-ce-$version is successfully installed"
else
     echo "issue with docker-ce installation - process abort"
     exit 1
fi
sudo apt-mark hold docker-ce
sudo service docker start ; clear
echo " "
#### Install Kubernetes latest components
echo "starting the installation of k8s components (kubeadm,kubelet,kubectl) ...."
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-get update ; clear
sudo apt-get install -y kubelet kubeadm kubectl
if [ $? -eq 0 ];then
     echo "kubelet, kubeadm & kubectl are successfully installed"
else
     echo "issue in installing kubelet, kubeadm & kubectl - process abort"
     exit 2
fi
sudo apt-mark hold kubelet kubeadm kubectl
echo " "

#### k8s with flannel pod network
echo "initializing kubernetes master ... may take couple of minutes ...."
sudo kubeadm init --pod-network-cidr=10.244.0.0/16 | grep discovery-token-ca-cert-hash > /tmp/kube-node-join.sh
if [ $? -eq 0 ];then
   echo " "
   echo "kubernetes master initiazied successfully..."
   echo "for kubeadm join command look at /tmp/kube-node-join.sh file"
   echo "setting up kube config for User `whoami` ......"
   sudo mkdir -p $HOME/.kube
   sudo rm $HOME/.kube/config
   sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
   sudo chown $(id -u):$(id -g) $HOME/.kube/config
else
   echo "cluster initilization failed - process abort..."
   exit 8
fi
echo " "
echo "Setting up flannel pod network"
echo " "
sudo kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/bc79dd1505b0c8681ece4de4c0d86c5cd2643275/Documentation/kube-flannel.yml
sleep 60
echo " "
kubectl get nodes
