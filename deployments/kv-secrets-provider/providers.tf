terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.75.0"
    }
  }
}

provider "azurerm" {
  use_oidc = true
  features {}
}
