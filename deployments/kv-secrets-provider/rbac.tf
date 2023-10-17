locals {
  kv_admin_role = "Key Vault Administrator"
}

resource "azurerm_role_assignment" "rbac_aks_identity_kvs" {
  for_each             = local.names
  scope                = lookup(local.kvs, each.key).id
  role_definition_name = local.kv_admin_role
  principal_id         = lookup(local.aks_with_kv, each.key).kv_secrets_provider_identity_object_id
  depends_on           = [local.kvs, local.aks_with_kv]
}
