
output "talosconfig" {
  value       = data.talos_client_configuration.talosconfig[0].talos_config
  sensitive   = true
  description = "Kubeconfig for the Talos cluster"
}

output "kubeconfig" {
  value       = talos_cluster_kubeconfig.kubeconfig.kubeconfig_raw
  sensitive   = true
  description = "Kubeconfig for the Talos cluster"
}
