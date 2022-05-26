# Install Java & Jenkins Using Script
```
sudo wget https://raw.githubusercontent.com/lerndevops/labs/master/scripts/installJenkins.sh -P /tmp
sudo chmod 755 /tmp/installJenkins.sh
sudo bash /tmp/installJenkins.sh
```
# Install Maven Using Script
``` 
sudo wget https://raw.githubusercontent.com/lerndevops/labs/master/scripts/installMaven.sh -P /tmp
sudo chmod 755 /tmp/installMaven.sh
sudo bash /tmp/installJenkins.sh
```

# Manual Installation Steps 
### Install JAVA
```
sudo add-apt-repository ppa:openjdk-r/ppa
sudo apt-get update
sudo apt-get install -y openjdk-8-jdk
```
### Install Maven  ( on Jenkins machine )
```
cd /tmp ; sudo wget https://dlcdn.apache.org/maven/maven-3/3.8.5/binaries/apache-maven-3.8.5-bin.tar.gz
cd /tmp ; sudo tar -xzf apache-maven-3.8.5-bin.tar.gz -C  /opt/
mv /opt/apache-maven-3.8.5 /opt/maven
sudo echo "MAVEN_HOME=\"/opt/maven\"" >> /etc/profile
sudo echo "PATH=\$MAVEN_HOME/bin:\$PATH" >> /etc/profile
source /etc/profile
````
### Install Jenkins
```
sudo wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo echo deb https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list
sudo apt-get update
sudo apt-get install jenkins
```
## `Below are Just FYI Only` 

##### Set JAVA_HOME & MAVEN_HOME as environment variables on Jenkins machine
```
sudo echo "MAVEN_HOME=\"/opt/apache-maven-3.8.5\"" >> /etc/profile
sudo echo "JAVA_HOME=\"/usr/lib/jvm/java-8-openjdk-amd64\"" >> /etc/profile 
sudo echo "PATH=\$JAVA_HOME/bin:\$MAVEN_HOME/bin:\$PATH" >> /etc/profile
source /etc/profile
```
##### how to restart Jenkins 
```
sudo systemctl restart jenkins  # to restart 
sudo systemctl stop jenkins     # to stop 
sudo systemctl start jenkins    # to start 
sudo systemctl status jenkins   # to check the status
```
