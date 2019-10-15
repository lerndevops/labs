Tools need to install on Jenkins machine / Server
  1) git
  2) maven
  3) java
  4) jenkins  ( https://github.com/lerndevops/labs/blob/master/jenkins/Install-Java-Jenkins-ubuntu.txt )
  5) docker   ( https://github.com/lerndevops/labs/blob/master/docker/Install-Docker-manual.txt )
  6) ansible  ( https://github.com/lerndevops/labs/blob/master/ansible/InsallAnsible.txt )

Required plugin to run the jobs
  1) PMD
  2) cobertura
  3) Junit
  4) build with parameters
  5) SonarQube Scanner ( if you using sonar for code review )
  
Create Credentials 
  Jenkins ( main page ) ==> Credentials ==> global ==> Add Credentials 
	--> kind: secret text 
	--> scope: Global 
	--> Secret: <enter your docker hub password ) 
	--> ID: DOCKER_HUB_PWD 
	--> Description: DOCKER_HUB_PWD

Setup Docker with Jenkins
   sudo usermod -aG docker jenkins ( add jenkins user to docker group to run docker commands with jenkins user )
   service jenkins restart ( mandatory to reflect the changes with jenkins )


