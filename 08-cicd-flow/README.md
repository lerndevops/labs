# Guide to Create a CI/CD Pipeline on Jenkins Using Docker & Ansible

## Step 1 -- Pre-Requisites

### Learning/Lab Environment
- 2 vCPU
- 4 GB RAM
- 20 GB Disk

### Minimum Requirements
- 1 vCPU
- 2 GB RAM

Create a VM (Cloud VM or VirtualBox VM) and install the required tools.

---

## Step 2 -- Install Java & Jenkins

Follow:

https://github.com/lerndevops/labs/blob/master/jenkins/Install/README.md

---

## Step 3 -- Install Maven

Follow:

https://github.com/lerndevops/labs/blob/master/jenkins/Install/README.md

---

## Step 4 -- Install Docker

```bash
sudo wget https://raw.githubusercontent.com/lerndevops/labs/master/scripts/installDocker.sh -P /tmp
sudo chmod 755 /tmp/installDocker.sh
sudo bash /tmp/installDocker.sh
```

---

## Step 5 -- Install Ansible

```bash

Follow:
https://github.com/lerndevops/labs/blob/master/03-ansible/01-labs/00-install.md

cd ~
ansible-config init --disabled > ansible.cfg
cd ~ ; vi ansible.cfg
```

Uncomment:

```ini
host_key_checking = False
```

> Note: Disabling host key checking is acceptable for lab environments. In production, host key checking should remain enabled.

---

## Step 6 -- Login to Jenkins UI

Open:

```text
http://<SERVER-IP>:8080
```

For cloud deployments, use the public IP and ensure port 8080 is allowed.

```bash
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

- Install Suggested Plugins
- Complete the setup wizard

---

## Step 7 -- Install Required Plugins

Manage Jenkins → Plugins

Install:

1. JUnit
2. coverage
3. Warnings NG
4. Build Pipeline (optional)
5. pipeline stage view 
6. Docker Pipeline

---

## Step 8 -- Create Docker Hub Credentials

Manage Jenkins → Credentials

```text
Kind: Username with Password
Scope: Global
Username: <Docker Hub Username>
Password: <Docker Hub Personal Access Token>
ID: DOCKER_HUB_LOGIN
Description: DOCKER_HUB_LOGIN
```

> Recommended: Use Docker Hub Personal Access Token (PAT) instead of your account password.

---

## Step 9 -- Configure Java, Maven & Git

### Java

```text
Manage Jenkins → Global Tool Configuration → JDK

Name: JDK21
JAVA_HOME: /path/to/java/home
```

### Maven

```text
Manage Jenkins → Global Tool Configuration → Maven

Name: Maven3
MAVEN_HOME: /path/to/maven/home
```

### Git

```text
Manage Jenkins → Global Tool Configuration → Git

Name: git
Path to Git executable: /usr/bin/git
```

---

## Step 10 -- Configure Jenkins to Run Docker

```bash
sudo usermod -aG docker jenkins
sudo systemctl restart jenkins
```

Validate:

```bash
sudo su - jenkins
docker version
docker ps
docker pull nginx
```

If these commands work without permission errors, Jenkins can successfully execute Docker commands.

---

## Step 11 -- Setup Deployment Environments

### Learning Environment

#### Kubernetes
- 1 Control Plane
- 1 Worker Node

OR

#### Docker Swarm
- 1 Manager
- 1 Worker

### Production Recommendation

#### Kubernetes
- Minimum 3 Control Plane Nodes
- Multiple Worker Nodes

#### Docker Swarm
- Minimum 3 Manager Nodes
- Multiple Worker Nodes

---

## Step 12 -- Setup Ansible Inventory

```bash
vi /tmp/inv

sudo chmod 640 /tmp/inv
sudo chown jenkins:jenkins /tmp/inv
```

Sample Inventory:

https://raw.githubusercontent.com/lerndevops/PetClinic/master/deploy/inv

> Ensure only manager/control-plane IPs are added as required. Do not add worker/node IPs unless your deployment model specifically requires them.

---

## Step 13 -- Create Pipeline as Code Job

### Create Job

```text
Jenkins Home → New Item

Name: CICD-Pipeline
Type: Pipeline
```

### Configure Job

```text
Pipeline Tab

Definition:
  Pipeline Script from SCM

SCM:
  Git

Repository URL:
  https://github.com/lerndevops/it-services-portal

Script Path:
  jenkins/cicd.gvy
```

Pipeline Script:

https://github.com/lerndevops/it-services-portal/blob/main/jenkins/cicd.gvy

Save and click **Build Now**.

---

## Recommended Best Practice

Store the Jenkinsfile (or cicd.gvy) inside the application repository and manage the pipeline as code.

Avoid maintaining build logic directly inside Jenkins jobs whenever possible.
