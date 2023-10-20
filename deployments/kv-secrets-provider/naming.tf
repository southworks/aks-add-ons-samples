module "naming" {
  for_each     = local.regions
  source       = "../../modules/naming/v1.0"
  product_area = local.product_area
  environment  = local.environment
  location     = each.key
  generator = {
    kvsp = { # keyvault secrets provider
      resource_group     = 1
      kubernetes_cluster = 1
      key_vault          = 1
    }
  }
}

locals {
  names = module.naming
}
