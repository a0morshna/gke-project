provider "google" {
  project     = var.project_id
  region      = var.region
  zone        = var.zone
}

module "network" {
  source          = "./modules/network/"
  region          = var.region
  project_id      = var.project_id
  network_name    = "${var.project_name}-vpc-network"
  global_name     = "${var.network_global_address_name}-global-network"
  subnetwork_name = "${var.project_name}-sub-network"
}

module "vault-kms" {
  source           = "./modules/kms"
  project_id       = var.project_id
  region           = "global"
  kms_crypto_key   = "vault_unseal_key"
}

module "gcp_storage" {
  source           = "./modules/storage"
  project_id       = var.project_id
  name             = "gcp-storage-7686"
  serviceaccount   = module.vault-kms.service_account
}

module "kubernetes" {
  source                 = "./modules/kubernetes/" 
  endpoint               = module.kubernetes_cluster.public_endpoint
  cluster_ca_certificate = base64decode(module.kubernetes_cluster.cluster_ca_certificate)
}

module "kubernetes_cluster" {
  source                 = "./modules/kubernetes_cluster/"
  region                 = var.region
  project_id             = var.project_id
  cluster_name           = "${var.project_name}-cluster"
  cluster_nodepool_name  = "${var.project_name}-nodepool"
  network                = module.network.network_name
  subnetwork             = module.network.subnetwork_name
  machine_type           = var.node_machine_type
  depends_on             = [module.network]
  unseal_keyring_name    = module.vault-kms.unseal_keyring_name
  cluster_ca_certificate = base64decode(module.kubernetes_cluster.cluster_ca_certificate)
  kubeconfig             = module.kubernetes_cluster.kubeconfig
  storage_bucket_name    = module.gcp_storage.storage_bucket_id
  endpoint               = "helmgkeproject.tk"
}
