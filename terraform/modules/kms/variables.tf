variable "region" {
}

variable "project_id" {
}

variable "kms_key_ring" {
  type = string
  default = ""
}

variable "keyring_location" {
  type    = string
  default = "global"
}

variable "kms_crypto_key" {
  type = string
}