locals {
  kv_sku                        = "standard"
  kv_soft_delete_retention_days = 7
  kvs                           = module.key_vaults
  kv_secret_name                = "mykvsecret"
  kv_secret_value               = "tempkvsecretvalue"
}

module "key_vaults" {
  for_each                    = local.names
  source                      = "../../modules/key_vault/v1.0"
  name                        = each.value.generated_names.kvsp.key_vault[0]
  location                    = each.key
  resource_group_name         = lookup(local.main_resource_groups, each.key)
  sku_name                    = local.kv_sku
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  enabled_for_disk_encryption = true
  soft_delete_retention_days  = local.kv_soft_delete_retention_days
  purge_protection_enabled    = true
  tags                        = local.tags
  depends_on                  = [local.main_resource_groups]
}

resource "azurerm_key_vault_secret" "my_kv_secret" {
  for_each     = local.names
  name         = local.kv_secret_name
  value        = local.kv_secret_value
  key_vault_id = lookup(local.kvs, each.key).id
  depends_on   = [local.kvs]
}

resource "azurerm_key_vault_access_policy" "aks_keys_secrets_get_permissions" {
  for_each     = local.names
  key_vault_id = lookup(local.kvs, each.key).id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = lookup(local.aks_with_kv, each.key).kv_secrets_provider_identity_client_id

  key_permissions = [
    "Get",
  ]

  secret_permissions = [
    "Get",
  ]

  depends_on = [local.kvs, local.aks_with_kv]
}
