# AGISIT Project Team 29
# This file defines the cluster using terraform

variable "region" {
    type = string
}

variable "project" {
    type = string
}

variable "workers_count" {
    type = number
}

#####################################################################
# GKE cluster Definition
resource "google_container_cluster" "online-boutique" {
  name     = "online-boutique"
  project = var.project
  location = var.region
  initial_node_count = var.workers_count

  addons_config {
    network_policy_config {
      disabled = true
    }
  }

  # Definition of Cluster Nodes
  node_config {
    machine_type = "n1-standard-4"
    oauth_scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/trace.append",
      "https://www.googleapis.com/auth/compute",
    ]
  }
}

#####################################################################
# Output for K8S
#####################################################################
output "client_certificate" {
  value     = google_container_cluster.online-boutique.master_auth.0.client_certificate
  sensitive = true
}

output "client_key" {
  value     = google_container_cluster.online-boutique.master_auth.0.client_key
  sensitive = true
}

output "cluster_ca_certificate" {
  value     = google_container_cluster.online-boutique.master_auth.0.cluster_ca_certificate
  sensitive = true
}

output "host" {
  value     = google_container_cluster.online-boutique.endpoint
  sensitive = true
}

output "cluster" {
  value     = google_container_cluster.online-boutique
  sensitive = true
}
