variable "project_id"{
}

variable "cluster_name" {
}

variable "cluster_nodepool_name" {
}

variable "region" {
}

variable "network" {
}

variable "subnetwork"{
}

variable "machine_type"{
}

variable "cluster_endpoint" {
  description = "Cluster endpoint"
  type        = string
  default     = "gkeproject.tk"
}

variable "kubernetes_secrets_crypto_key" {
  description = "Name of the KMS key to use for encrypting the Kubernetes database."
  type        = string
  default     = "kubernetes-secrets"
}

variable "cluster_ca_certificate" {
}


variable "unseal_keyring_name" {
  type        = string
  description = "Keyring name containing the GKMS key that will unseal Vault"
}

variable "storage_bucket_name" {
  type        = string
  description = "Name of Storage Account used for vault"
}

variable "kubeconfig" {
}

variable "endpoint" {

}