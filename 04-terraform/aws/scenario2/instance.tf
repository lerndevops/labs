resource "aws_instance" "web" {
  ami                    = "${var.ami}"
  instance_type          = "t2.micro"
  subnet_id              = "${aws_subnet.public-subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.sgweb.id}"]
}
