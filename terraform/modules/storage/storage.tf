# Create the storage bucket
resource "google_storage_bucket" "bucket" {
  name          = "${var.project_id}-${var.name}"
  project       = var.project_id
  force_destroy = true
  storage_class = "MULTI_REGIONAL"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    action {
      type = "Delete"
    }

    condition {
      num_newer_versions = 1
    }
  }

}