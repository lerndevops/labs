resource "aws_instance" "dev-instances" {
  count         = 3
  ami           = "ami-05692172625678b4e"
  instance_type = "t2.micro"
  key_name      = "jan18"
  associate_public_ip_address = true
  vpc_security_group_ids = ["sg-0b23770aa56a1ea15"]

  tags = {
    Name = "demoinstnce-${count.index}"
  }

  provisioner "local-exec" {

    command = "echo ${self.public_ip} >> /tmp/public_ips.txt"
  }
}

resource "null_resource" "setup-user" {

  depends_on = [aws_instance.dev-instances]

  provisioner "local-exec" {
   command = "ansible-playbook -i /tmp/public_ips.txt /root/IaC/setup-user.yml -u ubuntu --private-key /root/IaC/jan18.pem"
  }
}
resource "null_resource" "setup-tomcat" {

  depends_on = [null_resource.setup-user]

  provisioner "local-exec" {
   command = "ansible-playbook -i /tmp/public_ips.txt /root/IaC/tomcat.yml -u ubuntu --private-key /root/IaC/jan18.pem"
  }
}
