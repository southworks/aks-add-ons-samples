terraform {
  required_version = ">= 1.3.7"
  backend "azurerm" {
  }
}

terraform {
}

data "azurerm_subscription" "primary" {
}
