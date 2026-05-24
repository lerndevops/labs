# Install DockerCompose

### Install Using Script 
``` 
sudo wget https://raw.githubusercontent.com/lerndevops/labs/master/scripts/installDockerCompose.sh -P /tmp
sudo bash /tmp/installDockerCompose.sh
```
### Manual Installation Steps 
```
sudo curl -L https://github.com/docker/compose/releases/download/1.29.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```


```
docker-compose -f compose.yml up -d
docker ps
docker-compose -f compose.yml up --scale web=1 --scale app=2 --scale db=1 -d
docker-compose -f compose.yml up --scale web=3 --scale app=5 --scale db=2 -d
docker-compose -f compose.yml down
```
