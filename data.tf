data "google_compute_regions" "available" {
}
data "google_compute_zones" "available" {
}
output "regions" {
  value = data.google_compute_regions.available.names
}
output "zones" {
  value = data.google_compute_zones.available.names
}