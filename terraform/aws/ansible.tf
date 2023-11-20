resource "aws_instance" "dev" {
  tags = {
    Name = "test"
    env  = "dev"
  }
  ami = "ami-0e83be366243f524a"
  instance_type = "t2.micro"
  key_name = "ipat"
  security_groups = ["ipat", "default"]
  count = 1
  user_data = <<-EOF
                #!/bin/bash
                cd /tmp ; wget https://raw.githubusercontent.com/lerndevops/labs/master/scripts/setupUser.sh
                sudo bash /tmp/setupUser.sh
              EOF
  provisioner "local-exec" {
      command = "echo ${self.public_ip} > ./myinv"
  }
}
resource "null_resource" "dev" {

  depends_on = [aws_instance.dev]

  provisioner "local-exec" {
    working_dir = "/home/ubuntu/tcode"
    command = <<-EOT
               sleep 60
               ansible -i myinv all -m ping -u ubuntu --private-key ipat.pem
	             ansible-playbook -i myinv apache.yaml --user ubuntu --key-file ipat.pem
              EOT
   }
}
