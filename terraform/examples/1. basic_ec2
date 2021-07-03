### vim main.tf

provider "aws" {
  region     = "us-east-1"
  access_key = "key"
  secret_key = "secret"
}

resource "aws_instance" "test-instances" {
  ami  = "ami-02aa7f3de34db391a"
  count = "4"
  instance_type = "t2.micro"
  key_name = "du-devops"
  user_data = <<-EOF
                #! /bin/bash
                sudo apt-get update
                sudo git clone http://github.com/lerndevops/labs
                sudo chmod -R 775 labs
                sudo labs/cloud/setup-user.sh
        EOF

  tags = {
    Name = "test${count.index + 1}"
    training = "devops"
  }
}


#export TF_LOG=TRACE
#terraform init
#terraform plan
#terraform apply
#terraform destroy --auto-approve
