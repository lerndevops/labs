provider "aws" {
#  access_key = "accesskey_here"
#  secret_key = "SECRET_KEY_HERE"
  region     = "us-east-2"
}

resource "aws_instance" "test" {
  ami           = "ami-0b9064170e32bde34"
  instance_type = "t2.micro"
  key_name = "test"
  security_groups = ["test"]

  connection {
      type     = "ssh"
      user     = "ubuntu"
      host     = self.public_ip
      private_key = file("./test.pem")
  }
  provisioner "file" {
      source      = "/root/myterraproject/setup-user.sh"
      destination = "/tmp/setup-user.sh"
  }
  provisioner "remote-exec" {
      inline = [
        "chmod +x /tmp/setup-user.sh",
        "sudo /tmp/setup-user.sh",
      ]
  }
}
