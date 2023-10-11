output "environment" {
  description = "Environment value received as variable."
  value       = var.environment
}

output "env_abbr" {
  description = "The abbreviated environment name."
  value       = local.env_abbr
}

output "generated_names" {
  description = "A map containing the generated names."
  value       = local.generated_names
}

output "location" {
  description = "Location value received as variable."
  value       = var.location
}

output "location_abbr" {
  description = "The abbreviated location."
  value       = local.location_abbr
}
