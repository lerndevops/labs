## Install Kubernetes on Ubuntu 18.04 LTS 

### Step1: `On All Machines ( Master & All nodes ):`

    sudo apt-get update
    sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    sudo apt-get update ; clear
    sudo apt-get install -y docker-ce
    sudo service docker start ; clear

    echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
    curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
    sudo apt-get update ; clear
    sudo apt-get install -y kubelet kubeadm kubectl	
	
### Step2: `On Master only:`

    sudo kubeadm init --pod-network-cidr=10.244.0.0/16
	
    sudo mkdir -p $HOME/.kube
    sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    sudo chown $(id -u):$(id -g) $HOME/.kube/config

    kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/2140ac876ef134e0ed5af15c65e414cf26827915/Documentation/kube-flannel.yml
	
    kubectl get nodes
    kubectl get all --all-namespaces

### Step3: `On Nodes only:`
       
    copy the kubeadm join token from master & run it on all nodes
          
    Ex: kubeadm join 10.128.15.231:6443 --token mks3y2.v03tyyru0gy12mbt \
           --discovery-token-ca-cert-hash sha256:3de23d42c7002be0893339fbe558ee75e14399e11f22e3f0b34351077b7c4b56

#


## Install Kubernetes on CENTOS 

### Step1: `On All Machines ( Master & All nodes ):`

     ### Set SELinux in permissive mode (effectively disabling it)
     
     setenforce 0
     sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

     ### Install Docker
     
     sudo yum remove -y docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine docker-ce docker-ce-cli containerd.io
     sudo yum install -y yum-utils device-mapper-persistent-data lvm2
     sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
     sudo yum install -y docker-ce docker-ce-cli containerd.io
     systemctl enable --now docker
     systemctl start docker

     ### Install kubeadm,kubelet,kubectl
     
     cat <<EOF > /etc/yum.repos.d/kubernetes.repo
     [kubernetes]
     name=Kubernetes
     baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
     enabled=1
     gpgcheck=1
     repo_gpgcheck=1
     gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
     EOF

     yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
     systemctl enable --now kubelet

### Step2: `On Master only:`

    sudo kubeadm init --pod-network-cidr=10.244.0.0/16

    sudo mkdir -p $HOME/.kube
    sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
    sudo chown $(id -u):$(id -g) $HOME/.kube/config

    kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/2140ac876ef134e0ed5af15c65e414cf26827915/Documentation/kube-flannel.yml

    kubectl get nodes
    kubectl get all --all-namespaces

### Step3: `On Nodes only:`

    copy the kubeadm join token from master & run it on all nodes

    Ex: kubeadm join 10.128.15.231:6443 --token mks3y2.v03tyyru0gy12mbt \
           --discovery-token-ca-cert-hash sha256:3de23d42c7002be0893339fbe558ee75e14399e11f22e3f0b34351077b7c4b56




## how to find kubeadm join token later
```
token=`kubeadm token generate`
kubeadm token create "$token" --print-join-command --ttl=0
```
