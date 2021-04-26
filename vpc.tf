resource "google_compute_network" "vpc_network" {
  name                    = "terraform-vpc"
  auto_create_subnetworks = false
}
resource "google_compute_subnetwork" "public-subnetwork-1" {
  name          = "terraform-subnetwork-1"
  ip_cidr_range = "10.0.1.0/24"
  region        = var.gcp_region
  network       = google_compute_network.vpc_network.name
}
resource "google_compute_subnetwork" "public-subnetwork-2" {
  name          = "terraform-subnetwork-2"
  ip_cidr_range = "10.0.2.0/24"
  region        = var.gcp_region
  network       = google_compute_network.vpc_network.name
}

resource "google_compute_firewall" "compute_firewall" {
  name    = "terraform-firewall"
  network = google_compute_network.vpc_network.name
  source_ranges = ["0.0.0.0/0"]
  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443", "8080"]
  }

  source_tags = ["web"]
}