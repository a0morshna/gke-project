resource "google_compute_network" "network" {
  name                    = var.network_name
  project                 = var.project_id
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "subnet" {
  name          = var.subnetwork_name
  region        = var.region
  network       = google_compute_network.network.name
  ip_cidr_range = "10.0.0.0/24" 
  depends_on    = [google_compute_network.network]
}


/* resource "google_compute_firewall" "firewall" {
  name    = "firewall"
  project = var.project_id
  network = var.network_name

  allow {
    protocol = "tcp"
    ports    =  ["8080","80","8443"]
  }

} */