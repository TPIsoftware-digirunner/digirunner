variable "env" {
  description = "Workspace ENV"
  type        = string
}


variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "project_number" {
  description = "GCP Project Number"
  type        = string
}

variable "sid" {
  description = "Resources name assign in the head line"
  type        = string
}

variable "region" {
  description = "Google Cloud region"
  type        = string
}

variable "location" {
  description = "Google Cloud location"
  type        = string
}

variable "cluster_name" {
  description = "GKE cluster name"
  type        = string
}

# Network
variable "private_subnet_cidr" {
  description = "Private subnet CIDR"
  type        = string
}

# DB password
variable "DB_PASSWORD" {
  description = "DB password"
  type        = string
}
