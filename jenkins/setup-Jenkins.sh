#!/bin/bash


sudo apt install -y unzip wget
#Install JAVA

#sudo add-apt-repository ppa:webupd8team/java
#sudo apt-get update
#apt-get install -y oracle-java8-installer

sudo add-apt-repository ppa:openjdk-r/ppa
sudo apt-get update
sudo apt-get install -y openjdk-8-jdk

#Install Jenkins

wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
echo deb https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list
sudo apt-get update
sudo apt-get install -y jenkins
sudo systemctl start jenkins

#Install Maven  ( on Jenkins machine )

## cd /tmp ; wget http://mirrors.estointernet.in/apache/maven/maven-3/3.6.1/binaries/apache-maven-3.6.1-bin.tar.gz
## cd /tmp ; wget http://apachemirror.wuchna.com/maven/maven-3/3.6.2/binaries/apache-maven-3.6.2-bin.tar.gz
cd /tmp ; wget http://apachemirror.wuchna.com/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz
cd /tmp ; tar -xzf apache-maven-3.6.3-bin.tar.gz -C /opt

#Install SonarQube-runner ( on Jenkins machine )

#cd /tmp ; wget http://repo2.maven.org/maven2/org/codehaus/sonar/runner/sonar-runner-dist/2.4/sonar-runner-dist-2.4.zip
cd /tmp ; wget https://repo1.maven.org/maven2/org/codehaus/sonar/runner/sonar-runner-dist/2.4/sonar-runner-dist-2.4.zip
cd /tmp ; unzip sonar-runner-dist-2.4.zip
cd /tmp ; mv sonar-runner-2.4 /opt

#Set JAVA_HOME & MAVEN_HOME as environment variables on Jenkins machine
mkdir -p /home/backup
cp -p /etc/profile /home/backup/profile_`date +%d%b%Y-%H%M`
echo "MAVEN_HOME=/opt/apache-maven-3.6.3" >> /etc/profile
#echo "JAVA_HOME=/usr/lib/jvm/java-8-oracle" >> /etc/profile
echo "JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> /etc/profile
echo "PATH=\$JAVA_HOME/bin:\$MAVEN_HOME/bin:\$PATH" >> /etc/profile
source /etc/profile  ## to reload the configuration

exit

