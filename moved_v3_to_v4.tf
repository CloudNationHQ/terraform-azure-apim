moved {
  from = azurerm_api_management.apim
  to   = azurerm_api_management.this
}

moved {
  from = azurerm_role_assignment.apimcert["default"]
  to   = azurerm_role_assignment.this["this"]
}

moved {
  from = azurerm_api_management_custom_domain.apim["default"]
  to   = azurerm_api_management_custom_domain.this["this"]
}

moved {
  from = azurerm_api_management_redis_cache.apim["default"]
  to   = azurerm_api_management_redis_cache.this["this"]
}

moved {
  from = azurerm_api_management_logger.logger["default"]
  to   = azurerm_api_management_logger.this["this"]
}

moved {
  from = azurerm_api_management_api.api
  to   = azurerm_api_management_api.this
}

moved {
  from = azurerm_api_management_identity_provider_aad.provider["default"]
  to   = azurerm_api_management_identity_provider_aad.this["this"]
}

moved {
  from = azurerm_api_management_product.product
  to   = azurerm_api_management_product.this
}

moved {
  from = azurerm_api_management_user.user
  to   = azurerm_api_management_user.this
}
