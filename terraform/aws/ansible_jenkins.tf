# This autoomation create an AWS instance, and install jenkins inside with ansible automation
# we should have ansible installed in local terrafrm box.

# ansi.tf

provider aws {
  region = "us-east-1"
}
resource "aws_instance" "jenkins_master" {
    # Use an Ubuntu image
    ami = "ami-0747bdcabd34c712a"
    instance_type = "t2.micro"
    key_name = "terra"
    tags = {
        Name = "jenkins-master"
    }

    # This is where we configure the instance with ansible-playbook
    provisioner "local-exec" {
        command = "sleep 120; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ubuntu --private-key ./terra.pem -i '${aws_instance.jenkins_master.public_ip},' jenkins.yml"
    }
}

## jenkins.yml

- hosts: all
  become: true
  tasks:
    - name: Install Java 1.8
      apt: name=openjdk-8-jdk state=present update_cache=yes

    - name: jenkins apt repository key
      apt_key: url=https://pkg.jenkins.io/debian-stable/jenkins.io.key state=present

    - name: repository configuration
      apt_repository: repo='deb https://pkg.jenkins.io/debian-stable binary/' state=present

    - name: jenkins installation
      apt: name=jenkins update_cache=yes

    - name: jenkins  startup
      service: name=jenkins state=started
