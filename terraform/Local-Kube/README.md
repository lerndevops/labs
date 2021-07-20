***Install terraform on KUBERNETES MASTER Machine:***

cd /tmp ;wget https://releases.hashicorp.com/terraform/1.0.1/terraform_1.0.1_linux_amd64.zip

apt update;apt install -y unzip

unzip terraform_1.0.1_linux_amd64.zip

mv terraform /usr/local/bin/terraform

chmod 755 /usr/local/bin/terraform

terraform --version

**mkdir terraform**

vi main.tf
vi service.tf


#terraform init

#terraform plan

#terraform apply

#terraform destroy

**kubectl get all** 
