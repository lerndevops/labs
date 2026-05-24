

# Recommended: Install Ansible (All Linux)

## Prerequisite: Install pip for Python 3

### Ubuntu/Debian
```sh
sudo apt update
sudo apt install python3-pip
```

### CentOS/RHEL
```sh
sudo yum install python3-pip
```

## Using pipx (recommended)
```sh
sudo apt install pipx
python3 -m pipx ensurepath
pipx install --include-deps ansible
```

## Or using pip
```sh
python3 -m pip install --user ansible
```

# Legacy: Install using Script 
```sh
sudo wget https://raw.githubusercontent.com/lerndevops/labs/master/scripts/installAnsible.sh -P /tmp
sudo chmod 755 /tmp/installAnsible.sh
sudo bash /tmp/installAnsible.sh
```


# Legacy: Manual Installation Steps  

## Ubuntu/Debian (may not be latest)
```sh
sudo apt update
sudo apt install software-properties-common python3-pip
sudo apt-add-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
```

## CentOS/RHEL (may not be latest)
```sh
sudo yum -y install epel-release python3-pip
sudo yum -y update
sudo yum -y install ansible
```
