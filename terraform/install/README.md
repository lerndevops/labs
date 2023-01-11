# Install Using Script
```
sudo wget https://raw.githubusercontent.com/lerndevops/labs/master/scripts/installTerraform.sh -P /tmp
sudo chmod 755 /tmp/installTerraform.sh
sudo bash /tmp/installTerraform.sh
```

# Manual Installation Steps

### Install Terraform CLI on Ubuntu/Debian Linux OS 

```
sudo curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install terraform

Verify  :  terraform version
```

### Install Terraform CLI on CentOS/RHEL Linux OS 

```
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
sudo yum -y install terraform

Verify  :  terraform version
```
