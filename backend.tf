terraform {
  backend "gcs" {
    bucket = var.gcs_bucket
    prefix = "terraform/state"
  }
}
