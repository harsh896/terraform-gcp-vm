provider "google" {
  credentials = file(var.gcp_credentials_file)
  project     = var.gcp_project
  region      = var.gcp_region
}


terraform {
  backend "gcs" {
    bucket      = "terraform-gcp-backend-bucket"
    prefix      = "terraform/terraform.tfstate"
    credentials = "rosy.json"
  }
}