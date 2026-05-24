# Ansible Lab 01 - Installing Ansible and Configuring Inventory

## Install Ansible

```bash
sudo apt update
sudo apt install ansible -y
```

## Verify

```bash
ansible --version
```

## Create Inventory

```ini
[ubuntu_servers]
ubuntu-node1 ansible_host=192.168.1.10
ubuntu-node2 ansible_host=192.168.1.11
```

## Test Connectivity

```bash
ansible ubuntu_servers -i inventory.ini -m ping
```