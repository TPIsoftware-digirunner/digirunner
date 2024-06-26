# create VPC
resource "google_compute_network" "vpc" {
  name                    = "${var.sid}-${var.env}-vpc"
  project                 = var.project_id
  routing_mode            = "REGIONAL"
  auto_create_subnetworks = false

}

# create subnet
resource "google_compute_subnetwork" "digi_subnet1" {
  depends_on = [ google_compute_network.vpc ]
  project                    = var.project_id
  name                       = "digi-subnet-p1"
  ip_cidr_range              = "10.203.21.0/24"
  network                    = "https://www.googleapis.com/compute/v1/projects/${var.project_id}/global/networks/${google_compute_network.vpc.name}"
  # network                    = google_compute_network.vpc.id
  private_ipv6_google_access = "DISABLE_GOOGLE_ACCESS"  
  purpose                    = "PRIVATE"
  region                     = var.region
  stack_type                 = "IPV4_ONLY"
  secondary_ip_range = [
    {
    range_name    = "gke-digirunner-pods"
    ip_cidr_range = "10.32.0.0/14"
    },
    {
    range_name    = "gke-digirunner-services"
    ip_cidr_range = "10.36.0.0/20"
  }]
}
