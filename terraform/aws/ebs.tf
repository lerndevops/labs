
resource "aws_instance" "test" {
  count = 3
  ami  = "ami-00399ec92321828f5"
  instance_type = "t2.micro"
  tags = {
      Name = "test"
  }

}

resource "aws_s3_bucket" "mys3bucket" {
   bucket = "testing-s3-with-terraform-naresh"
   force_destroy = true
   acl = "private"
   versioning {
      enabled = true
   }
   tags = {
     Name = "Bucket1"
     Environment = "Test"
   }
}

resource "aws_security_group" "mywebappsg" {
  name = "mywebappsg"
  description = "Web Security Group"
  tags = {
      Name = "mywebappsg"
  }
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_ebs_volume" "example" {
  size              = 40
  availability_zone = "us-east-2a"
  tags = {
    Name = "HelloWorld"
  }
}

