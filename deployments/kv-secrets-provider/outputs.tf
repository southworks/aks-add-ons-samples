output "kv_secrets_names_default" {
  description = "Name of all the generated secrets (default) for all the KVs."
  value = {
    for region, secret in azurerm_key_vault_secret.my_kv_secret : region => secret.name
  }
}

output "kv_names" {
  description = "The name of all the generated KVs."
  value = {
    for region, kv in local.kvs : region => kv.name
  }
}

output "aks_names" {
  description = "Name of all the generated AKS instances."
  value = {
    for region, aks in local.aks_with_kv : region => aks.name
  }
}

output "resource_groups_names" {
  description = "Name of all the created resource groups."
  value = {
    for region, rg in local.main_resource_groups : region => rg.name
  }
}

output "aks_identity_client_ids" {
  description = "The Managed Identity Client ID of all the AKS instances."
  value = {
    for region, aks in local.aks_with_kv : region => aks.kv_secrets_provider_identity_client_id
  }
}

output "regions" {
  description = "Regions where a deployment has been created."
  value = [
    for key, value in local.regions : key
  ]
}
