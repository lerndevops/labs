# Install Using Script
```
sudo wget https://raw.githubusercontent.com/lerndevops/labs/master/scripts/installDocker.sh -P /tmp
sudo chmod 755 /tmp/installDocker.sh
sudo bash /tmp/installDocker.sh
```

# Manual Installation Steps

### Install Docker on Ubuntu:
```
sudo su -
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

## Test the installation by running a simple container:

	docker run hello-world

## FYI Only ## Check Available Version for Install

	apt-cache madison docker-ce | awk '{print $3}'
```

### Install Docker on CentOS/Fedora/amznLinux
```
sudo yum install -y device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install -y docker-ce docker-ce-cli containerd.io
sudo systemctl start docker
sudo systemctl enable docker

## Test the installation by running a simple container:
	docker run hello-world
```

# Add your user to the docker group
```
## Add your user to the docker group, giving the user permission to run docker commands:

        sudo usermod -aG docker devops
```
# Install DockerCompose
### Install Using Script 
``` 
sudo wget https://raw.githubusercontent.com/lerndevops/labs/master/scripts/installDockerCompose.sh -P /tmp
sudo chmod 755 /tmp/installDockerCompose.sh
sudo bash /tmp/installDockerCompose.sh
```
### Manual Installation Steps 
```
sudo curl -L https://github.com/docker/compose/releases/download/$DC_VERSION/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```
