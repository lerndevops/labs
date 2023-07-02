# Manual Installation Steps 
### Install JAVA
```
sudo add-apt-repository ppa:openjdk-r/ppa
sudo apt-get update
sudo apt-get install -y fontconfig openjdk-11-jre openjdk-11-jdk
```
### Install Maven  ( on Jenkins machine )
```
cd /tmp ; sudo wget https://dlcdn.apache.org/maven/maven-3/3.9.3/binaries/apache-maven-3.9.3-bin.tar.gz
cd /tmp ; sudo tar -xzf apache-maven-3.9.3-bin.tar.gz -C  /opt/
mv /opt/apache-maven-3.9.3 /opt/maven
sudo echo "MAVEN_HOME=\"/opt/maven\"" >> /etc/profile
sudo echo "PATH=\$MAVEN_HOME/bin:\$PATH" >> /etc/profile
source /etc/profile
````
### Install Jenkins
```
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins
```

## `Below are Just FYI Only` 

##### how to restart Jenkins 
```
sudo systemctl restart jenkins  # to restart 
sudo systemctl stop jenkins     # to stop 
sudo systemctl start jenkins    # to start 
sudo systemctl status jenkins   # to check the status
```


##### Set JAVA_HOME & MAVEN_HOME as environment variables on Jenkins machine
```
sudo echo "MAVEN_HOME=\"/opt/apache-maven-3.8.5\"" >> /etc/profile
sudo echo "JAVA_HOME=\"/usr/lib/jvm/java-8-openjdk-amd64\"" >> /etc/profile 
sudo echo "PATH=\$JAVA_HOME/bin:\$MAVEN_HOME/bin:\$PATH" >> /etc/profile
source /etc/profile
```

