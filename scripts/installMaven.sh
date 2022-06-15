#!/bin/bash

#Install Maven
MAVEN_VERSION=3.8.6
sudo wget https://downloads.apache.org/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz -P /tmp
sudo tar -xzf /tmp/apache-maven-$MAVEN_VERSION-bin.tar.gz -C  /opt/
sudo mv /opt/apache-maven-$MAVEN_VERSION /opt/maven
exit 0
