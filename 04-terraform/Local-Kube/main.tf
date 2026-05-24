provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_deployment" "k8s-deployment" {
  metadata {
    name = "deploy1"
    labels = {
      name = "deploy1"
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        name = "web"
      }
    }

    template {
      metadata {
        labels = {
          name = "web"
        }
      }

      spec {
        container {
          image = "leaddevops/petclinic"
          name  = "cont1"

        }
      }
    }
  }
}
