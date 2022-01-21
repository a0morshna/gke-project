data "google_client_config" "client" {}

data "template_file" "access_token" {
  template = data.google_client_config.client.access_token
}

# Like projects, key rings names must be globally unique within the project.
resource "random_id" "kms_random" {
  prefix      = "kubernetes-secrets"
  byte_length = "8"
}

# Obtain the key ring ID or use a randomly generated on.
locals {
  kms_key_ring = random_id.kms_random.hex
}

# Create the KMS key ring
resource "google_kms_key_ring" "kubernetes-secrets" {
  name     = local.kms_key_ring
  location = var.region
  project  = var.project_id
}

# Create the crypto key for encrypting Kubernetes secrets
resource "google_kms_crypto_key" "kubernetes-secrets" {
  name            = var.kubernetes_secrets_crypto_key
  key_ring        = google_kms_key_ring.kubernetes-secrets.id
  rotation_period = "604800s"
}

# Grant GKE access to the key
resource "google_kms_crypto_key_iam_member" "kubernetes-secrets-gke" {
  crypto_key_id = google_kms_crypto_key.kubernetes-secrets.id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = "serviceAccount:237161474134-compute@developer.gserviceaccount.com"
}