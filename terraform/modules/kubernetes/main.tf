data "google_client_config" "client" {}

data "template_file" "access_token" {
  template = data.google_client_config.client.access_token
}

provider "kubernetes" {
  host                   = "https://${var.endpoint}" 
  token                  = data.google_client_config.client.access_token
  cluster_ca_certificate = var.cluster_ca_certificate
}