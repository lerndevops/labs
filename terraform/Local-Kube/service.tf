resource "kubernetes_service" "svc1" {
  metadata {
    name = "petsvc1"
    labels = {
      name = "web"
    }
  }
  spec {
    selector = {
      name = "web"
    }
    port {
      port        = 1234
      target_port = 8080
      node_port   = 30080
    }
    type = "NodePort"
  }
}
