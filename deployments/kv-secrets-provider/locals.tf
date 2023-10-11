locals {
  environment  = var.environment
  product_area = "gaz"
  regions = {
    eastus = "eastus"
  }
  tags = {
    environment     = local.environment
    owner_team      = "gaspar-az"
    confidentiality = "internal"
    business_unit   = "cloud-devops-pocs"
  }
}
