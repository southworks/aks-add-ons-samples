variable "environment" {
  description = "Environment used to generate the names."
  type        = string
  validation {
    condition = (
      var.environment != null
      && contains(["test", "gaz"], var.environment)
    )
    error_message = "Invalid 'environment'. It must not be null and be one of: management, production, staging, test."
  }
}

variable "generator" {
  description = "Map of domains/resources/quantity to generate the names."
  type        = map(map(number))
  default = {
    "domain" = {
      "resource" = 1
    }
  }
  validation {
    condition = (
      var.generator != null
      && length(var.generator) > 0
      && !contains(
        [for domain, resources in var.generator : (
          domain != null
          && !contains(
            [for resource_type, resource_count in resources : (
              resource_count != null && resource_count >= 0
          )], false)
      )], false)
    )
    error_message = "Invalid input for 'generator' variable."
  }
}

variable "location" {
  description = "Location used to generate the names."
  type        = string
}

variable "product_area" {
  type        = string
  description = "Owning organization, functional team, or portfolio of the resources to which the application is utilizing"
  validation {
    condition = (
      var.product_area != null && length(var.product_area) == 3
    )
    error_message = "Invalid 'product_area'. It must be exactly 3 characters long."
  }
}
