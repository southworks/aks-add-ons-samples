resource "azurerm_kubernetes_cluster" "k8s_cluster" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  sku_tier            = var.sku_tier
  tags                = var.tags

  default_node_pool {
    name                = var.default_node_pool_name
    vm_size             = var.vm_size
    max_pods            = var.max_pods
    enable_auto_scaling = var.enable_auto_scaling
    node_count          = var.node_count
    min_count           = var.min_count
    max_count           = var.max_count
    vnet_subnet_id      = var.vnet_subnet_id
    zones               = var.availability_zones
  }

  identity {
    type = "SystemAssigned"
  }

  key_vault_secrets_provider {
    secret_rotation_enabled  = var.secret_rotation_enabled
    secret_rotation_interval = var.secret_rotation_interval
  }

  api_server_access_profile {
    authorized_ip_ranges = flatten([var.authorized_ip_ranges])
  }

  dynamic "network_profile" {
    for_each = var.network_policy == null ? [] : [var.network_policy]

    content {
      network_plugin = var.network_plugin
      network_policy = var.network_policy

      load_balancer_profile {
        outbound_ip_address_ids = flatten([var.outbound_ip_address_ids])
      }
    }
  }

  dynamic "http_proxy_config" {
    for_each = var.set_http_proxy_config ? [var.set_http_proxy_config] : []

    content {
      http_proxy  = var.http_proxy
      https_proxy = var.https_proxy
      no_proxy    = var.no_proxy
      trusted_ca  = var.trusted_ca
    }
  }

  lifecycle {
    ignore_changes = [
      http_proxy_config, // recommended by Terraform. This config only applies at creation time
    ]
  }
}
