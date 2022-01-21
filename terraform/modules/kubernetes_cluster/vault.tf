  
/* resource "kubernetes_namespace" "vault" {
  metadata {
    name = "vault"
  }
  depends_on = [var.kubeconfig]
} */

resource "helm_release" "vault" {
  name      = "vault"
  chart     = "/home/omors/Documents/-study/gke-project/vault-chart/jenkins-chart-0.1.0.tgz"
  #namespace = kubernetes_namespace.vault.metadata.0.name

  set {
    name  = "vault.key_ring"
    value =  var.unseal_keyring_name
  }
  set {
    name  = "vault.region"
    value = "global"
  }
  set {
    name  = "vault.bucket"
    value =  var.storage_bucket_name
  }
  set {
    name  = "vault.project"
    value =  var.project_id
  }
  set {
    name  = "vault.gcpsasecretname"
    value = "gcp-vault-sa"
  }
  depends_on = [var.kubeconfig]
}