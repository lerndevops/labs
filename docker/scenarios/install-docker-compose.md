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