# Project ID
variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

# Region for the GKE cluster
variable "region" {
  description = "The GCP region"
  type        = string
}

# Path to the GCP Service Account key
variable "gcp_credentials_file" {
  description = "Path to the GCP Service Account JSON file"
  type        = string
}

# GCS bucket for Terraform state
variable "gcs_bucket" {
  description = "GCS bucket name to store Terraform state"
  type        = string
}

# GKE Cluster name
variable "cluster_name" {
  description = "Name of the GKE cluster"
  type        = string
}
