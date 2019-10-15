To run job1 to job7 without failure, need to setup below accordingly
========================================================================================================

Tools need to install on Jenkins machine / Server
  1) git
  2) maven
  3) java
  4) jenkins  ( https://github.com/lerndevops/labs/blob/master/jenkins/Install-Java-Jenkins-ubuntu.txt )
  5) docker   ( https://github.com/lerndevops/labs/blob/master/docker/Install-Docker-manual.txt )
  6) ansible  ( https://github.com/lerndevops/labs/blob/master/ansible/InsallAnsible.txt )

Required plugin to run the jobs ( install all these from Jenkins UI )
  Manage Jenkins --> manage plugins -- Available -- search & install the below
  	1) PMD
  	2) cobertura
  	3) Junit
  	4) build with parameters
  	5) SonarQube Scanner ( if you using sonar for code review )
  
Create Credentials ( Setup these from Jenkins UI )
  Jenkins ( main page ) ==> Credentials ==> global ==> Add Credentials 
	--> kind: secret text 
	--> scope: Global 
	--> Secret: <enter your docker hub password> 
	--> ID: DOCKER_HUB_PWD 
	--> Description: DOCKER_HUB_PWD

Setup Docker with Jenkins
   sudo usermod -aG docker jenkins ( add jenkins user to docker group to run docker commands with jenkins user )
   service jenkins restart ( mandatory to reflect the changes with jenkins )

Setup Ansible Inventory
   vi /tmp/inv 
   enter your servers in gruops called qa & prod 
   ( look at the sample inventory file under https://github.com/lerndevops/samplejavaapp/tree/master/deploy )
   ensure to update the qa & prod server credentials accrodingly in /tmp/inv file

