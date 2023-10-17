output "kv_name_east_us" {
  description = "Name of the Key Vault deployed in East US region."
  value       = local.kvs[local.regions.eastus].name
}

output "kv_east_us_secret_name" {
  description = "Name of the secret created for the Key Vault deployed in East US region."
  value       = local.kv_secret_name
}
