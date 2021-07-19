resource "aws_instance" "aws-multi-instance" {
  count         = 2
  ami           = "ami-0747bdcabd34c712a"
  instance_type = "t2.micro"

  tags = {
    Name = "demoinstnce-${count.index}"
  }
}

output "instance_ip_addr" {
  value = aws_instance.aws-multi-instance[*].public_ip
}
