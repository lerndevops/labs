provider "google" {
  credentials = file("keyfile_downloaded")
  project = "project-id"
  region  = "us-central1"
  zone    = "us-central1-a"
}

resource "google_compute_instance" "testvm" {
  name = "vm1"
  machine_type = "e2-medium"
  zone = "us-central1-a"
  boot_disk {
    initialize_params {
      image = "ubuntu-1804-bionic-v20210720"
    }
  }
  network_interface {
    network = "default"
    access_config {}
  }
}
