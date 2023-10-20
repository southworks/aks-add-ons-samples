locals {
  aks_sku_tier                 = "Standard"
  aks_secret_rotation_interval = "2m"
  aks_with_kv                  = module.aks_clusters
}

module "aks_clusters" {
  for_each                 = local.names
  source                   = "../../modules/kubernetes_cluster/v1.0"
  name                     = each.value.generated_names.kvsp.kubernetes_cluster[0]
  location                 = each.key
  resource_group_name      = lookup(local.main_resource_groups, each.key).name
  dns_prefix               = each.value.generated_names.kvsp.kubernetes_cluster[0]
  sku_tier                 = local.aks_sku_tier
  secret_rotation_enabled  = true
  secret_rotation_interval = local.aks_secret_rotation_interval
  tags                     = local.tags
  network_policy           = null
  network_plugin           = null
  load_balancer_sku        = null
  depends_on               = [local.main_resource_groups]
}
