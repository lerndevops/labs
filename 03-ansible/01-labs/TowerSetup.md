# AWX (Ansible Tower) Setup Guide

Follow these steps to set up AWX (Ansible Tower) and its dependencies on Ubuntu.

---

## 1. Clone Required Repositories

```sh
git clone https://github.com/ansible/awx
git clone https://github.com/lerndevops/labs
```

---

## 2. Install Ansible

```sh
cd labs/
cd ansible/
./installAnsible.sh
```

---

## 3. Update System and Install Dependencies

```sh
sudo apt-get update
sudo apt install python3-pip
sudo apt-get update
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
```

---

## 4. Install Docker

```sh
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
docker -v
```

---

## 5. Install Docker Compose

```sh
pip3 install docker-compose
```

---

## 6. Navigate to AWX Installer

```sh
cd ../..
cd awx/
ls
cd installer/
ls
```

---

## 7. Deploy AWX

```sh
ansible-playbook -i inventory install.yml
```

---

## 8. Verify Docker Containers

```sh
docker ps
```

---

**Note:**  
- Make sure your user is in the `docker` group or use `sudo` with Docker commands.
- Ensure you have Ansible installed before running the playbook.
- If you encounter issues, verify all dependencies are correctly installed.