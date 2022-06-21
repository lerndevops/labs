# Install Docker on CentOS/Fedora/amznLinux

### Install Docker `Using Script`

```
sudo wget https://raw.githubusercontent.com/lerndevops/labs/master/scripts/installDocker.sh -P /tmp
sudo chmod 755 /tmp/installDocker.sh
sudo bash /tmp/installDocker.sh
```


### Install Docker With `Manual Steps`

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