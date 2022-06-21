# Install Jenkins on Tomcat

## download JAVA,Tomcat & Jenkins.war 

```
wget https://github.com/lerndevops/code/raw/main/jdk-8u331-linux-x64.tar.gz -P /tmp
wget https://github.com/lerndevops/code/raw/main/apache-tomcat-9.0.63.tar.gz -P /tmp 
wget https://get.jenkins.io/war-stable/2.332.3/jenkins.war -P /tmp
```

## Extract the JAVA & TOMCAT to /opt
```
tar -xzf /tmp/jdk-8u331-linux-x64.tar.gz -C /opt
mv /opt/jdk1.8.0_331 /opt/java
tar -xzf /tmp/apache-tomcat-9.0.63.tar.gz -C /opt
mv /opt/apache-tomcat-9.0.63 /opt/tomcat
```

## Setup the JAVA Environtment 
```
sudo echo "JAVA_HOME=\"/opt/java\"" >> /etc/profile 
sudo echo "PATH=\$JAVA_HOME/bin:\$PATH" >> /etc/profile
source /etc/profile
```

## Deploy the Jenkins.war to Tomcat 
```
mv /tmp/jenkins.war /opt/tomcat/webapps/
```

## Start the Tomcat Server 
```
/opt/tomcat/bin/startup.sh

Validate: ps -ef|grep tomcat
```

## Access the Jenkins from Tomcat

```
in Browser: http://<PublicIP-of-Server>:8080/jenkins

ex: http://146.148.91.129:8080/jenkins
```
