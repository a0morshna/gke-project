# Key rings names must be globally unique within the project.
resource "random_id" "kms_random" {
  prefix      = var.kms_key_ring
  byte_length = "8"
}

# Create the KMS key ring
resource "google_kms_key_ring" "vault" {
  name     = random_id.kms_random.hex
  location = var.keyring_location
  project  = var.project_id
}

# Create the crypto key for encrypting init keys
resource "google_kms_crypto_key" "vault-init" {
  name            = var.kms_crypto_key
  key_ring        = google_kms_key_ring.vault.id
  rotation_period = "604800s"
}

# Create Service Account for Vault to fetch unseal keys
resource "google_service_account" "vault_kms" {
  account_id   = "vault-kms"
  display_name = "Vault auto-unseal"
  project      = var.project_id
}

# Grant service account access to the key
resource "google_kms_crypto_key_iam_member" "vault-init" {
  crypto_key_id = google_kms_crypto_key.vault-init.id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = "serviceAccount:237161474134-compute@developer.gserviceaccount.com"
}
