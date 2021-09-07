terraform {
  backend "s3" {
    bucket = "testtestte2983479283"
    key    = "terraform/terraform.tfstate"
    region = "us-east-2"
    access_key = "accesskey"
    secret_key = "secretkey"
  }
}
resource "aws_instance" "test" {
  count = 3
  ami  =  "ami-00399ec92321828f5"
  instance_type = "t2.micro"

  tags = {
     Name = "demoinstance-${count.index}"
  }
}
