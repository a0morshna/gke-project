resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region
  
  remove_default_node_pool = true
  initial_node_count       = 1

  network         = var.network
  subnetwork      = var.subnetwork
  
}

resource "google_container_node_pool" "primary_nodes" {
  name       = var.cluster_nodepool_name
  location   = var.region
  cluster    = google_container_cluster.primary.name
  node_count = 1

  node_config {
    preemptible  = true
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloudkms",
      "https://www.googleapis.com/auth/cloud-platform",
      "https://www.googleapis.com/auth/compute",
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring"
   ]

    labels = {
      env = var.project_id
    }
   
    machine_type = var.machine_type
    tags         = [var.cluster_nodepool_name, var.cluster_name]
    metadata     = {
      disable-legacy-endpoints = "true"
    }
  }
}
