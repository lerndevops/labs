# Install Using Script
```
sudo wget https://raw.githubusercontent.com/lerndevops/labs/master/scripts/installDocker.sh -P /tmp
sudo chmod 755 /tmp/installDocker.sh
sudo bash /tmp/installDocker.sh
```

# Manual Installation Steps

### Install Docker on Ubuntu:
```
 sudo apt-get update
 sudo apt-get install -y apt-transport-https ca-certificates curl gnupg software-properties-common lsb-release
 
 ## Add Dockers official GPG key & stable repo
 sudo mkdir -p /etc/apt/keyrings
 curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
 echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

## Install Docker latest
sudo apt-get update ; clear
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

## Test the installation by running a simple container:

	docker run hello-world

## FYI Only ## Check Available Version for Install

	apt-cache madison docker-ce | awk '{print $3}'
```

### Install Docker on CentOS/Fedora/amznLinux
```
sudo su -
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo systemctl start docker
sudo systemctl enable docker

## Test the installation by running a simple container:
	docker run hello-world
```

# Add your user to the docker group
```
why?

By Default docker software needs root previlige to run on a server
when we install it also it starts runnings as root user
so, a regular user can not run / use docker commands 

also, when you installed docker software it creates a system group called docker

so that, we can add regular users (ex: devops/ubuntu) on system to the docker group, 
with which regular users (ex: devops/ubuntu) can run docker commands
```
```
## Add your user to the docker group, giving the user permission to run docker commands:

        sudo usermod -aG docker devops
```
