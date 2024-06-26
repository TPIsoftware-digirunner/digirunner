resource "google_container_cluster" "digirunner" {
  depends_on = [ google_compute_subnetwork.digi_subnet1 ]
  timeouts {
    create = "30m"
    update = "20m"
  }

  name                      = var.cluster_name
  location                  = var.location
  project                   = var.project_id
  initial_node_count        = 1
  default_max_pods_per_node = 110

  network = "projects/${var.project_id}/global/networks/${google_compute_network.vpc.name}"
  subnetwork = "projects/${var.project_id}/regions/${var.region}/subnetworks/${google_compute_subnetwork.digi_subnet1.name}"
  networking_mode = "VPC_NATIVE"

  node_version = data.google_container_engine_versions.get_version.default_cluster_version
  min_master_version = data.google_container_engine_versions.get_version.default_cluster_version

  datapath_provider         = "LEGACY_DATAPATH"

  addons_config {
    dns_cache_config {
      enabled = false
    }

    gce_persistent_disk_csi_driver_config {
      enabled = true
    }

    horizontal_pod_autoscaling {
      disabled = false
    }

    http_load_balancing {
      disabled = false
    }

    network_policy_config {
      disabled = true
    }
  }

  binary_authorization {
    evaluation_mode = "DISABLED"
  }

  database_encryption {
    state = "DECRYPTED"
  }

  default_snat_status {
    disabled = false
  }

  enable_shielded_nodes = true

  ip_allocation_policy {
    # cluster_ipv4_cidr_block       = "10.32.0.0/14"
    cluster_secondary_range_name  = "gke-digirunner-pods"
    # services_ipv4_cidr_block      = "10.36.0.0/20"
    services_secondary_range_name = "gke-digirunner-services"
  }

  logging_config {
    enable_components = ["SYSTEM_COMPONENTS", "WORKLOADS"]
  }

#   logging_service = "logging.googleapis.com/kubernetes"

  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }

  monitoring_config {
    enable_components = ["SYSTEM_COMPONENTS"]

    managed_prometheus {
      enabled = false
    }
  }

  network_policy {
    enabled  = false
    provider = "PROVIDER_UNSPECIFIED"
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
    # service_account = google_service_account.default.email
    service_account = "default"

    shielded_instance_config {
      enable_integrity_monitoring = true
    }
  }

  notification_config {
    pubsub {
      enabled = false
    }
  }

#   pod_security_policy_config {
#     enabled = false
#   }

  private_cluster_config {
    enable_private_endpoint = false
    # enable_private_endpoint = true

    master_global_access_config {
      enabled = false
      # enabled = true
    }
  }

  release_channel {
    channel = "STABLE"
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }
}
