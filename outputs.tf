output "service" {
  description = "contains all api management configuration"
  value       = azurerm_api_management.this
}

output "apis" {
  description = "contains all api configuration"
  value       = azurerm_api_management_api.this
}

output "products" {
  description = "contains all product configuration"
  value       = azurerm_api_management_product.this
}

output "users" {
  description = "contains all user configuration"
  value       = azurerm_api_management_user.this
}

output "loggers" {
  description = "contains all logger configuration"
  value       = azurerm_api_management_logger.this
}

output "custom_domains" {
  description = "contains all custom domain configuration"
  value       = azurerm_api_management_custom_domain.this
}

output "redis_caches" {
  description = "contains all redis cache configuration"
  value       = azurerm_api_management_redis_cache.this
}

output "identity_providers" {
  description = "contains all identity provider configuration"
  value       = azurerm_api_management_identity_provider_aad.this
}

output "role_assignments" {
  description = "contains all role assignment configuration"
  value       = azurerm_role_assignment.this
}
