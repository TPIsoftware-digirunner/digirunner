provider "google" {
  credentials = file("../tf-digi.json")
  project     = var.project_id
  region      = var.region
}

terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.6.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "kubectl" {
  load_config_file = true
  config_path = "~/.kube/config"
  # host = "https://$ {data.google_container_cluster.digirunner2.endpoint}"
  # token = "$ {data.google_container_cluster.digirunner2.access_token}"
  # cluster_ca_certificate = "$ {base64decode (data.google_container_cluster.digirunner2.master_auth.0.cluster_ca_certificate)}"
}
