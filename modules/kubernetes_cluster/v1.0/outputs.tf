output "id" {
  description = "The Kubernetes Managed Cluster ID."
  value       = azurerm_kubernetes_cluster.k8s_cluster.id
}

output "name" {
  description = "The Kubernetes Managed Cluster name."
  value       = azurerm_kubernetes_cluster.k8s_cluster.name
}

output "kubelet_identity" {
  description = "A kubelet_identity block. Contains the object_id."
  value       = azurerm_kubernetes_cluster.k8s_cluster.kubelet_identity[0]
}

output "kv_secrets_provider_identity_client_id" {
  description = "The Client ID of the user-defined Managed Identity used by the Secret Provider."
  value       = azurerm_kubernetes_cluster.k8s_cluster.key_vault_secrets_provider[0].secret_identity[0].client_id
}

output "kv_secrets_provider_identity_object_id" {
  description = "The Object ID of the user-defined Managed Identity used by the Secret Provider."
  value       = azurerm_kubernetes_cluster.k8s_cluster.key_vault_secrets_provider[0].secret_identity[0].object_id
}

output "kv_secrets_provider_identity_user_assigned_identity_id" {
  description = "The ID of the User Assigned Identity used by the Secret Provider."
  value       = azurerm_kubernetes_cluster.k8s_cluster.key_vault_secrets_provider[0].secret_identity[0].user_assigned_identity_id
}
