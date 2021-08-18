## Install Terraform CLI on Linux OS 

### Step1: 

> Download the appropriate Terraform binary package for the provided lab server VM (Linux 64-bit) using the wget command:

```
cd /tmp ; wget -c https://releases.hashicorp.com/terraform/1.0.1/terraform_1.0.1_linux_amd64.zip
```

### Step2: 

> Unzip the downloaded file

```
apt update ; apt-get install -y unzip     --  on Ubuntu / Debian Systems
yum update ; yum install –y unzip     --  on RHEL/Centos/Fedora 

unzip /tmp/terraform*.zip

```

### Step3:	

> Place the Terraform binary in the PATH of the VM operating system so the binary is accessible system-wide to all users:

```
sudo mv /tmp/terraform /usr/local/bin
```

### Step4: 

> Verify  :  terraform version

