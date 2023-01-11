resource "null_resource" "kube-deployment" {

connection {
      type     = "ssh"
      user     = "devops"
      host     = "hostip"
      password = "*********"
      #private_key = file("./edusep13.pem")
}
provisioner "remote-exec" {

  inline = [
     "sudo touch /tmp/hello.txt",
     "sudo kubectl create deployment helloapp --image=nginx",
  ]
}
}
