## Guide to CREATE A CICD Pipeline on Jenkins Using Docker & Ansible

#### Step1 -- Pre-Req

`**Create a VM (on any cloud OR Virtual Box) with 1CPU 2GB RAM**`

`**login to the VM Install below tools**`

#### Step2 -- Install Java - Jenkins - Maven: `follow below instruction from link below`

	[INSTALL-JAVA-JENKINS-MAVEN](https://github.com/lerndevops/labs/blob/master/jenkins/Install-Java-Jenkins-ubuntu.txt)

#### Step3 -- Install Docker: `follow below instruction from link below`
    
	[INSTALL-DOCKER](https://github.com/lerndevops/labs/blob/master/docker/install/Install-Docker-manual.txt)

#### Step4 -- Install Ansible: `follow below instruction from link below`

    [INSTALL-ANSIBLE](https://github.com/lerndevops/labs/blob/master/ansible/install/InsallAnsible.txt)


#### Step5 -- configure Jenkins with Docker 

> **by default Jenkins process runs with Jenkins User, which mean any jenkins Jobs we run from jenkins console will be running jenkins user on Jenkins machine**

> **we need to configure Jenkins user can run the docker commands by adding jenkins user to docker group**
  
        `sudo usermod -aG docker jenkins`
			    
> **restart the Jenkins Service**

        `sudo service jenkins restart`
			   
> **validate, run docker command with jenkins**

        `su - jenkins`
		`docker ps`
		`docker pull nginx`
		
	if the above commands execute without any error then we configured jenkins user properly 


#### Step6 -- Provide Jenkins user sudoers permission

 
> ** add jenkins user to sudoers, so that we can run jenkins jobs with ansible user to connect to target machines**

        `echo -e 'jenkins  ALL=(ALL)  NOPASSWD:  ALL' > /etc/sudoers.d/jenkins`


#### Step7 -- configure ssh keys for ansible user & copy to targets, `follow the instruction in below link`

> since we are going to use the same jenkins machine as ansible controller, create user & configure the ssh keys to target machines. 
	
    [SSH-KEYS-SETUP](https://github.com/lerndevops/labs/blob/master/ansible/install/ssh-keys-setup.md)


#### Step8 -- Now Let's start creating CICD Pipeline on Jenkins

```
hit `http://IP:8080` in browser ## incase of cloud please use Public IP ensure the Port is allowed to access. 

enter `initialAdminPassword` the page to login ( cat /var/lib/jenkins/secrets/initialAdminPassword )
	
click on `Install Suggested Plugins`

continue next and finish the setup. 
```
