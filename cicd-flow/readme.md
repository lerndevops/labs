## Guide to CREATE A CICD Pipeline on Jenkins Using Docker & Ansible

### Step1 -- `Pre-Req`

```
      Create a VM (on any cloud OR Virtual Box) with 1CPU 2GB RAM

      login to the VM Install below tools
```
### Step2 -- `Install Java - Jenkins - Maven: follow instruction from link below`

   [INSTALL-JAVA-JENKINS-MAVEN](https://github.com/lerndevops/labs/blob/master/jenkins/Install-Java-Jenkins-ubuntu.txt)

### Step3 -- `Install Docker: follow instruction from link below`
    
   [INSTALL-DOCKER](https://github.com/lerndevops/labs/blob/master/docker/install/Install-Docker-manual.txt)

### Step4 -- `Install Ansible: follow instruction from link below`

   [INSTALL-ANSIBLE](https://github.com/lerndevops/labs/blob/master/ansible/install/InsallAnsible.txt)

### Step5 -- `configure Jenkins with Docker` 

> by default Jenkins process runs with Jenkins User, which mean any jenkins Jobs we run from jenkins console will be running jenkins user on Jenkins machine

> we need to configure Jenkins user can run the docker commands by adding jenkins user to docker group

    sudo usermod -aG docker jenkins
			    
> restart the Jenkins Service  

    sudo service jenkins restart
			   
> validate, run docker command with jenkins
```
	su - jenkins  ## switch to jenkins user
	docker ps     ## to list any containers running
	docker pull nginx  ## pull a docker image 
```

##### if the above commands execute without any error then we configured jenkins user properly 

### Step6 -- `Provide Jenkins user sudoers permission`
 
> add jenkins user to sudoers, so that we can run jenkins jobs with ansible user to connect to target machines

    echo -e 'jenkins  ALL=(ALL)  NOPASSWD:  ALL' > /etc/sudoers.d/jenkins

### Step7 -- `configure ssh keys for ansible user & Setup target Environments`

> since we are going to use the same jenkins machine as ansible controller, create user & configure the ssh keys. 
	
> setup two docker swarm clusters one for QA & one for PROD
```
       create two VMs for QA & create docker swarm cluster one manager & one node
       create two VMs for PROD & create docker swarm cluster one manager & one node 
```
> Copy the ssh-keys for ansible user from Jenkins machine (acting as ansible controller) to QA Swarm Manager & PROD Swarm Manager so that Jenkins can connect & deploy the containers. 

   [SSH-KEYS-SETUP](https://github.com/lerndevops/labs/blob/master/ansible/install/ssh-keys-setup.md)

### Step8 -- `Setup Ansible Inventory`

```
   vi /tmp/inv 
   enter your servers in gruops called qa & prod 
   ( look at the sample inventory file under https://github.com/lerndevops/samplejavaapp/tree/master/deploy )
   ensure to update the qa & prod server credentials accrodingly in /tmp/inv file
```

### Step9 -- `Login to Jenkins UI`

```
	hit `http://IP:8080` in browser ## incase of cloud please use Public IP ensure the Port is allowed to access. 

	enter `initialAdminPassword` the page to login ( cat /var/lib/jenkins/secrets/initialAdminPassword )

	click on `Install Suggested Plugins`

	continue next and finish the setup. 
```

### Step10 -- `Install reqired Plugins (Install these from Jenkins UI)`
```
install all these from Jenkins UI )
  Manage Jenkins --> manage plugins -- Available -- search & install the below
  	1) PMD
  	2) cobertura
  	3) Junit
  	4) build with parameters
  	5) BuildPipeline
```

### Step11 -- `Create Credentials (Setup these from Jenkins UI)`

```
  Jenkins ( main/home page ) ==> Credentials ==> global ==> Add Credentials 
	--> kind: secret text 
	--> scope: Global 
	--> Secret: <enter your docker hub password> 
	--> ID: DOCKER_HUB_PWD 
	--> Description: DOCKER_HUB_PWD
```
### Step12 -- `Configure JAVA - MAVEN - Git (Setup these from Jenkins UI)`

```
Java configuration in Jenkins console 
	
	Manage Jenkins --> Global Tool Configuration --> JDK --> Add JDK
		Name: myjava ( can be any string )
		JAVA_HOME: /path/to/javahome ( ex: /usr/lib/jvm/java-8-openjdk-amd64 )

Maven Configuration in Jenkins console
	
	Manage Jenkins --> Global Tool Configuration --> Maven --> Add Maven
		Name: maven3.6 ( can be any string )
		MAVEN_HOME: /path/to/mavenhome ( ex: /opt/apache-maven-3.6.3 )
		
Git Configuration in Jenkins console
	
	Manage Jenkins --> Global Tool Configuration --> Git --> Add Git
		Name: git ( can be any string )
		MAVEN_HOME: /path/to/githome ( ex: /usr/bin/git )
```

## Step 13: Now Let's start creating CICD Pipeline
