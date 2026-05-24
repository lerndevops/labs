# Manual Installation Steps 
### Install JAVA (OpenJDK 21)
```
sudo apt update
sudo apt install -y fontconfig openjdk-21-jre
java -version
```
### Install Maven  ( on Jenkins machine )
```
cd /tmp
sudo wget https://dlcdn.apache.org/maven/maven-3/3.9.16/binaries/apache-maven-3.9.16-bin.tar.gz
sudo tar -xzf apache-maven-3.9.16-bin.tar.gz -C /opt/
sudo mv /opt/apache-maven-3.9.16 /opt/maven
echo 'export MAVEN_HOME="/opt/maven"' | sudo tee -a /etc/profile
echo 'export PATH=$MAVEN_HOME/bin:$PATH' | sudo tee -a /etc/profile
source /etc/profile
```
### Install Jenkins
```
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update
sudo apt install jenkins
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

