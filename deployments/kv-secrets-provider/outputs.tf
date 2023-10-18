output "kv_name_east_us" {
  description = "Name of the Key Vault deployed in East US region."
  value       = local.kvs[local.regions.eastus].name
}

output "kv_east_us_secret_name" {
  description = "Name of the secret created for the Key Vault deployed in East US region."
  value       = local.kv_secret_name
}

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