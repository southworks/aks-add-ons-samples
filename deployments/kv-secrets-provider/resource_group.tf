resource "azurerm_resource_group" "main_resource_group" {
  for_each = local.names
  name     = each.value.generated_names.integration.resource_group[0]
  location = each.key
  tags     = local.tags
}

locals {
  main_resource_groups = azurerm_resource_group.main_resource_group
}
