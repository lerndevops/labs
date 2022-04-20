### Guide to CREATE A `CICD Pipeline` on Jenkins Using Docker & Ansible  

## Step1 -- `Pre-Requisite`

```
      Create a VM (on any cloud OR Virtual Box) with 1CPU 2GB RAM

      login to the VM Install below tools
```

## Step2 -- `Install Java & Jenkins`
```
sudo wget https://raw.githubusercontent.com/lerndevops/labs/master/scripts/installJenkins.sh -P /tmp
sudo chmod 755 /tmp/installJenkins.sh
sudo bash /tmp/installJenkins.sh
```

## Step3 -- `Install Maven` 
```
sudo https://raw.githubusercontent.com/lerndevops/labs/master/scripts/installMaven.sh -P /tmp
sudo chmod 755 /tmp/installMaven.sh
sudo bash /tmp/installJenkins.sh
```

## Step4 -- `Install Docker`
```
sudo wget https://raw.githubusercontent.com/lerndevops/labs/master/scripts/installDocker.sh -P /tmp
sudo chmod 755 /tmp/installDocker.sh
sudo bash /tmp/installDocker.sh
```

## Step5 -- `Install Ansible: follow instruction from link below`
```
sudo wget https://raw.githubusercontent.com/lerndevops/labs/master/scripts/installAnsible.sh -P /tmp
sudo chmod 755 /tmp/installAnsible.sh
sudo bash /tmp/installAnsible.sh
```

## Step6 -- `configure Jenkins with Docker` 

> by default Jenkins process runs with Jenkins User, which mean any jenkins Jobs we run from jenkins console will be running jenkins user on Jenkins machine

> we need to configure Jenkins user can run the docker commands by adding jenkins user to docker group

```
    sudo usermod -aG docker jenkins
```		   

> **`restart the Jenkins Service`**  

```
    sudo service jenkins restart
```	

> validate, run docker command with jenkins

```
	su - jenkins           ## switch to jenkins user
	docker ps              ## to list any containers running
	docker pull nginx      ## pull a docker image 
```

##### if the above commands execute without any error then we configured jenkins user properly 

## Step7 -- `Setup Deployment Environments`

> **setup atleast one docker swarm / kubernetes cluster**

```
       create two VMs for QA, Install the required toos & setup the kubernetes cluster, one master - one worker node
```

## Step8 -- `Setup Ansible Inventory on Jenkins machine`

```
   vi /tmp/inv 
      enter your servers in groups like qa & prod 
   sudo chmod 755 /tmp/inv
   sudo chown jenkins:jenkins /tmp/inv
 
   // look at the sample inventory file under https://raw.githubusercontent.com/lerndevops/PetClinic/master/deploy/inv 
   
   Note: ensure to put only manager IPs in inventory file -- DO NOT PUT NODE IPs
```
