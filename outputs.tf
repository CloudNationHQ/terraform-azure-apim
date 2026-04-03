output "config" {
  description = "contains all api management configuration"
  value       = azurerm_api_management.apim
}

output "apis" {
  description = "contains all api configuration"
  value       = azurerm_api_management_api.api
}

output "products" {
  description = "contains all product configuration"
  value       = azurerm_api_management_product.product
}

output "users" {
  description = "contains all user configuration"
  value       = azurerm_api_management_user.user
}

output "loggers" {
  description = "contains all logger configuration"
  value       = azurerm_api_management_logger.logger
}

output "custom_domains" {
  description = "contains all custom domain configuration"
  value       = azurerm_api_management_custom_domain.apim
}

output "redis_caches" {
  description = "contains all redis cache configuration"
  value       = azurerm_api_management_redis_cache.apim
}

output "identity_providers" {
  description = "contains all identity provider configuration"
  value       = azurerm_api_management_identity_provider_aad.provider
}

output "role_assignments" {
  description = "contains all role assignment configuration"
  value       = azurerm_role_assignment.apimcert
}
