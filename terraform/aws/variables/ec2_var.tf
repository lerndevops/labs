resource "aws_instance" "test" {
  ami           = "ami-05692172625678b4e"
  instance_type = var.instancetype
}

#terraform plan will show the assignment
#terraform plan -var="instancetype=t2.small"
#If we dont define any default, if we dont give anything as commandline arg,  it explicitly asks to enter value.
#terraform.tfvars ----> This file can be used to give values of variables. 
