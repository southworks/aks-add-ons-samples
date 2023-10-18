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

output "regions" {
  description = "Regions where a deployment has been created."
  value = [
    for key, value in local.regions : key
  ]
}
