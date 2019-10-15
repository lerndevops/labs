Tools need to install on Jenkins machine / Server
  1) java
  2) jenkins
  3) git
  4) maven
  5) docker
  6) ansible

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
