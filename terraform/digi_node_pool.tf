resource "google_container_node_pool" "digi_pool" {
#   depends_on = [ google_container_cluster.digirunner ]
  timeouts {
    create = "30m"
    update = "20m"
  }
  name               = "digi-pool"
  cluster            = var.cluster_name
  location           = var.location
  project            = var.project_id
  initial_node_count = 1
  max_pods_per_node  = 110

  version = data.google_container_engine_versions.get_version.default_cluster_version

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  network_config {
    enable_private_nodes = false
    # enable_private_nodes = true
  }

  node_config {
    disk_size_gb = 100
    disk_type    = "pd-ssd"
    # disk_type    = "pd-standard"
    image_type   = "COS_CONTAINERD"
    machine_type = "n2d-standard-2"

    metadata = {
      disable-legacy-endpoints = "true"
    }
    oauth_scopes    = ["https://www.googleapis.com/auth/cloud-platform"]

    # oauth_scopes    = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]    
    # service_account = google_service_account.default.email
    service_account = "default"

    shielded_instance_config {
      enable_integrity_monitoring = true
    }
  }

  upgrade_settings {
    max_surge       = 1
    max_unavailable = 0
  }

}
