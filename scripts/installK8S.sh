#!/bin/bash

install_ubuntu() {
   which docker 
   if [ $? -eq 0 ];then
      #### Remove any pre installed docker packages  
      sudo service docker stop
      sudo apt-mark unhold docker-ce
      sudo apt-get remove -y docker docker-ce docker-ce-cli docker.io containerd runc kubeadm kubectl kubelet
      cd /var/lib
      sudo rm -r docker
   else
      echo "docker not installed.. continue to install"
   fi

   #### Install Specific Docker version
   sudo apt-get update
   sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
 
   ## Add Dockers official GPG key
   curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
   sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
   sudo apt-get update ; clear
   sudo apt-get install -y docker-ce docker-ce-cli containerd.io --allow-downgrades

   if [ $? -eq 0 ];then
      echo "docker-ce is successfully installed"
      sudo apt-mark hold docker-ce
      sudo wget https://raw.githubusercontent.com/lerndevops/labs/master/kube/install/daemon.json -P /etc/docker
      sudo service docker restart ; clear
   else
      echo "issue with docker-ce installation - process abort"
      exit 1
   fi
   echo " "

   #### Install Kubernetes latest components
   echo "starting the installation of k8s components (kubeadm,kubelet,kubectl) ...."
   echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
   curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
   sudo apt-get update ; clear
   sudo apt-get install -y kubelet kubeadm kubectl

   if [ $? -eq 0 ];then
      echo "kubelet, kubeadm & kubectl are successfully installed"
      sudo apt-mark hold kubelet kubeadm kubectl docker-ce docker-ce-cli
   else
      echo "issue in installing kubelet, kubeadm & kubectl - process abort"
      exit 2
   fi
}

install_centos() {

    which docker
    if [ $? -eq 0 ];then
       sudo yum remove docker-client-latest docker-latest docker-latest-logrotate docker-logrotate docker-engine
       cd /var/lib
       rm -rf docker
       yum clean
    else
       echo "docker is not installed... continue to install"
    fi

    sudo yum install -y yum-utils   ## device-mapper-persistent-data lvm2
    sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    sudo yum install -y docker-ce docker-ce-cli containerd.io
    sudo systemctl enable docker.service
    
    if [ $? -eq 0 ];then
       echo "docker-ce is successfully installed"
       yum install -y wget
       sudo wget https://raw.githubusercontent.com/lerndevops/labs/master/kube/install/daemon.json -P /etc/docker
       sudo service docker restart ; clear
    else
       echo "issue with docker-ce installation - process abort"
       exit 1
    fi
   echo " "

    # Install kubeadm, kubelet, kubectl 

cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-\$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
exclude=kubelet kubeadm kubectl
EOF
  
    # Set SELinux in permissive mode (effectively disabling it)
    sudo setenforce 0
    sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config
    sudo yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
    sudo systemctl enable --now kubelet
}
################ MAIN ###################

if [ -f /etc/os-release ];then
   osname=`grep ID /etc/os-release | egrep -v 'VERSION|LIKE|VARIANT' | cut -d'=' -f2 | sed -e 's/"//' -e 's/"//'`
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
