#!/bin/bash

install_ubuntu() {

    #Install JAVA11
    sudo add-apt-repository ppa:openjdk-r/ppa
    sudo apt-get update
    sudo apt-get install -y openjdk-11-jdk

    #Install Jenkins

    sudo wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
    sudo echo deb https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list
    sudo apt-get update
    sudo apt-get install jenkins
    sudo systemctl start jenkins
}

install_centos() {

    #install Java8
    clear
    sudo yum install -y yum-utils epel-release
    sudo yum update
    sudo yum install java-1.8.0-openjdk-devel

    #install Jenkins
    sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
    sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
    sudo yum install epel-release # repository that provides 'daemonize'
    sudo yum install jenkins
    sudo systemctl start jenkins
}


#Set JAVA_HOME & MAVEN_HOME as environment variables on Jenkins machine
#mkdir -p /home/backup
#cp -p /etc/profile /home/backup/profile_`date +%d%b%Y-%H%M`
#echo "MAVEN_HOME=/opt/apache-maven-3.8.3" >> /etc/profile
#echo "JAVA_HOME=/usr/lib/jvm/java-8-oracle" >> /etc/profile
#echo "JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> /etc/profile
#echo "PATH=\$JAVA_HOME/bin:\$MAVEN_HOME/bin:\$PATH" >> /etc/profile
#source /etc/profile  ## to reload the configuration

################ MAIN ###################

if [ -f /etc/os-release ];then
   osname=`grep ID /etc/os-release | egrep -v 'VERSION|LIKE|VARIANT' | cut -d'=' -f2 | sed -e 's/"//' -e 's/"//'`
   echo $osname
   if [ $osname == "ubuntu" ];then
       install_ubuntu
   elif [ $osname == "amzn" ];then
       install_centos
   elif [ $osname == "centos" ];then
       install_centos
  fi
else
   echo "can not locate /etc/os-release - unable find the osname"
   exit 8
fi
exit 0
