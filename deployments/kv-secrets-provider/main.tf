terraform {
  required_version = ">= 1.3.7"
  backend "azurerm" {
    resource_group_name  = var.backend_rg_name
    storage_account_name = var.backend_storage_account_name
    container_name       = var.backend_container_name
    key                  = "terraform.tfstate"
  }
}

terraform {
}

data "azurerm_subscription" "primary" {
}
