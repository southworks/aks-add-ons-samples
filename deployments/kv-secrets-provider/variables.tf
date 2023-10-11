variable "environment" {
  description = "The environment."
  type        = string
  default     = "test"
}

variable "backend_rg_name" {
  description = "The azurerm backend resource group name."
  type        = string
  default     = "rg-gasper"
}

variable "backend_storage_account_name" {
  description = "The azurerm backend storage account name."
  type        = string
  default     = "sagasperbackend"
}

variable "backend_container_name" {
  description = "The azurerm backend container name."
  type        = string
  default     = "gaztfstate"
}