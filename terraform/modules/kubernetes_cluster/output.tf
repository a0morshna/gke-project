output "cluster_name"{
    value = google_container_cluster.primary.name
}

output "client_certificate"{
    value = google_container_cluster.primary.master_auth.0.client_certificate
}

output "client_key"{
    value = google_container_cluster.primary.master_auth.0.client_key
}

output "cluster_ca_certificate"{
    value = google_container_cluster.primary.master_auth.0.cluster_ca_certificate
}

output "public_endpoint"{
    value = google_container_cluster.primary.endpoint
}

output "kubeconfig" {
   value = [
      {
        host                   = google_container_cluster.primary.endpoint
        token                  = data.google_client_config.client.access_token
        cluster_ca_certificate = google_container_cluster.primary.master_auth.0.cluster_ca_certificate
      }
   ]
}

output "node_pool_id_client" {
   value = google_container_node_pool.primary_nodes.id
}