resource "google_compute_global_address" "digi_ip" {
  project = var.project_id
  name = "dgr-ingress"
  address_type  = "EXTERNAL"
}

output "output_google_compute_global_address" {
  value = google_compute_global_address.digi_ip.address

}
