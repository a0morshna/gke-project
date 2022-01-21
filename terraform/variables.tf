variable "project_id" {
  description = "Google Cloud Platform (GCP) Project ID."
  type        = string
  default     = "lithe-cocoa-337808"
}

variable "project_name" {
  description = "Google Cloud Platform (GCP) Project name."
  type        = string
  default     = "cicd-task"
}

variable "region" {
  description = "GCP region name."
  type        = string
  default     = "europe-central2"
}

variable "zone" {
  description = "GCP zone name."
  type        = string
  default     = "europe-central2-a"
}


variable "network_global_address_name" {
  description = "Address name for private network."
  type        = string
  default     = "private-ip-address"
}


variable "node_machine_type"{
  description = "Machine type for kubernetes node."
  type        = string
  default     = "e2-micro"
}


variable "chart_path" {  
  description = "Path for helm chart."
  type        = string
  default     = "/home/omors/Documents/-study/gke-project/helm-chart-for-jenkins/values.yaml"
}

variable "helm_name" {
  description = "Helm name"
  type        = string
  default     = "wheel"
}