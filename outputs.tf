output "config" {
  description = "contains all redis cache configuration"
  value       = azurerm_api_management.apim
}

output "user_assigned_identities" {
  description = "contains all user assigned identities configuration"
  value       = azurerm_user_assigned_identity.identity
}
