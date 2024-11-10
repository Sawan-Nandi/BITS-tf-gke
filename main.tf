# Google Cloud provider configuration
provider "google" {
  project     = var.project_id
  region      = var.region
  credentials = file(var.gcp_credentials_file)  # The GCP SA key file from Jenkins
}

# GKE Cluster Resource
resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region

  initial_node_count = 3

  node_config {
    machine_type = "e2-medium"
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }

  # Enabling Kubernetes Engine API
  enable_legacy_abac = false
}

# Output for the GKE Cluster details
output "cluster_name" {
  value = google_container_cluster.primary.name
}

output "cluster_endpoint" {
  value = google_container_cluster.primary.endpoint
}

output "cluster_ca_certificate" {
  value = google_container_cluster.primary.master_auth.0.cluster_ca_certificate
}
