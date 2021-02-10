#!/bin/bash

#### Remove if a cluster is already running
sudo kubeadm reset -f
sleep 30

#### Remove any pre installed docker packages  
sudo yum remove -y docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine docker-ce docker-ce-cli containerd.io
cd /var/lib
sudo rm -r docker

#### Install Specific Docker version
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install -y docker-ce docker-ce-cli containerd.io
if [ $? -eq 0 ];then
     echo "docker-ce-$version is successfully installed"
else
     echo "issue with docker-ce installation - process abort"
     exit 1
fi
sudo systemctl enable --now docker
sudo systemctl start docker
echo " "

sudo yum remove -y kubeadm kubelet kubectl
#### Install Kubernetes latest components
echo "starting the installation of k8s components (kubeadm,kubelet,kubectl) ...."
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

sudo setenforce 0
sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config
sudo yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
sudo systemctl enable --now kubelet
if [ $? -eq 0 ];then
     echo "kubelet, kubeadm & kubectl are successfully installed"
else
     echo "issue in installing kubelet, kubeadm & kubectl - process abort"
     exit 2
fi
echo " "
