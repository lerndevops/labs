provider "google" {
  credentials = file("/Users/nareshwar/tcode/gcp-cred.json")
  project = "publ-365609"
  region = "us-central1"
  zone = "us-central1-c"
}

resource "google_compute_instance" "dev" {
  count = 1
  name = "test-${count.index}"
  machine_type = "e2-micro"
  boot_disk {
    initialize_params {
      image = "ubuntu-2004-focal-v20221213"
    }
  }
  network_interface {
    network = "default"
  }
}
