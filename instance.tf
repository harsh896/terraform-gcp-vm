data "google_compute_image" "compute_image" {
  family  = "ubuntu-2010"
  project = "ubuntu-os-cloud"

}
resource "google_compute_address" "ip_address" {
  name = "terraform-ip-address"
}


resource "google_compute_instance" "compute_instance" {
  name         = "terraform-instance"
  machine_type = "e2-small"
  zone         = data.google_compute_zones.available.names[2]
  allow_stopping_for_update = true
  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = data.google_compute_image.compute_image.self_link
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.name
    subnetwork = google_compute_subnetwork.public-subnetwork-1.name
    access_config {
      nat_ip = google_compute_address.ip_address.address
    }
  }
  metadata = {
    foo = "bar"
  }
  metadata_startup_script = "echo hi > /test.txt"

}