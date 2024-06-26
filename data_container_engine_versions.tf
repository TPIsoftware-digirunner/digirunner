data "google_container_engine_versions" "get_version" {
  provider       = google-beta
  location       = var.location
  project        = var.project_id
  version_prefix = "1.24."
}

output "output_gke_version" {
  value = data.google_container_engine_versions.get_version.default_cluster_version
}