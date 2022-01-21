data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = "https://${module.kubernetes_cluster.public_endpoint}"
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(module.kubernetes_cluster.cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    host                   = "https://${module.kubernetes_cluster.public_endpoint}"
    token                  = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(module.kubernetes_cluster.cluster_ca_certificate)
  }
}
