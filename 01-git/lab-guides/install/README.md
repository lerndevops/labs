# Install Using Script

```
sudo wget https://raw.githubusercontent.com/lerndevops/labs/master/scripts/installGit.sh -P /tmp
sudo chmod 755 /tmp/installGit.sh
sudo bash /tmp/installGit.sh
```

# Manual Installation Steps 

### Install Git on - Ubuntu OS
```
sudo su -
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:git-core/ppa -y
sudo apt-get update
sudo apt-get install git -y
git --version ( if it writes the version then the installation is successful )
```
### Install Git On - CentOS / Fedora / RedHat / amzn Linux
```
sudo yum install yum-utils
sudo yum update
sudo yum install git
```
