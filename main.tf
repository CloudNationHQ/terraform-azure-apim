resource "azurerm_api_management" "apim" {
  name                          = var.config.name
  location                      = coalesce(lookup(var.config, "location", null), var.location)
  resource_group_name           = coalesce(lookup(var.config, "resource_group", null), var.resource_group)
  publisher_name                = var.config.publisher_name
  publisher_email               = var.config.publisher_email
  sku_name                      = var.config.sku_name
  client_certificate_enabled    = try(var.config.client_certificate_enabled, null)
  gateway_disabled              = try(var.config.gateway_disabled, null)
  min_api_version               = try(var.config.min_api_version, null)
  zones                         = try(var.config.zones, null)
  notification_sender_email     = try(var.config.notification_sender_email, null)
  public_ip_address_id          = try(var.config.public_ip_address_id, null)
  public_network_access_enabled = try(var.config.public_network_access_enabled, null)
  virtual_network_type          = try(var.config.virtual_network_type, "None")

  dynamic "additional_location" {
    for_each = try(var.config.additional_location, null) != null ? { default = var.config.additional_location } : {}
    content {
      location             = additional_location.value.location
      capacity             = try(additional_location.value.capacity, null)
      zones                = try(additional_location.value.zones, null)
      public_ip_address_id = try(additional_location.value.public_ip_address_id, null)
      gateway_disabled     = try(additional_location.value.gateway_disabled, null)

      dynamic "virtual_network_configuration" {
        for_each = lookup(additional_location.value, "virtual_network_configuration", null) != null ? [lookup(additional_location.value, "virtual_network_configuration")] : []
        content {
          subnet_id = try(virtual_network_configuration.value.subnet_id, null)
        }
      }
    }
  }

  dynamic "certificate" {
    for_each = try(var.config.certificate, null) != null ? { default = var.config.certificate } : {}
    content {
      encoded_certificate  = certificate.value.encoded_certificate
      store_name           = certificate.value.store_name
      certificate_password = try(certificate.value.certificate_password, null)
    }
  }

  dynamic "delegation" {
    for_each = try(var.config.delegation, null) != null ? { default = var.config.delegation } : {}
    content {
      subscriptions_enabled     = try(delegation.value.subscriptions_enabled, false)
      user_registration_enabled = try(delegation.value.user_registration_enabled, false)
      url                       = try(delegation.value.url, null)
      validation_key            = try(delegation.value.validation_key, null)
    }
  }

  dynamic "hostname_configuration" {
    for_each = try(var.config.hostname_configuration, null) != null ? { default = var.config.hostname_configuration } : {}
    content {
      dynamic "proxy" {
        for_each = lookup(hostname_configuration.value, "proxy", null) != null ? [lookup(hostname_configuration.value, "proxy")] : []
        content {
          default_ssl_binding             = try(proxy.value.default_ssl_binding, false)
          host_name                       = proxy.value.host_name
          key_vault_id                    = try(proxy.value.key_vault_id, null)
          certificate                     = try(proxy.value.certificate, null)
          certificate_password            = try(proxy.value.certificate_password, null)
          negotiate_client_certificate    = try(proxy.value.negotiate_client_certificate, false)
          ssl_keyvault_identity_client_id = try(proxy.value.ssl_keyvault_identity_client_id, null)
        }
      }
    }
  }

  dynamic "identity" {
    for_each = lookup(var.config, "identity", null) != null ? [var.config.identity] : []
    content {
      type = identity.value.type
      identity_ids = concat(
        try([azurerm_user_assigned_identity.identity["identity"].id], []),
        lookup(identity.value, "identity_ids", [])
      )
    }
  }

  dynamic "protocols" {
    for_each = try(var.config.protocols, null) != null ? { default = var.config.protocols } : {}
    content {
      enable_http2 = try(protocols.value.enable_http2, false)
    }
  }

  dynamic "security" {
    for_each = try(var.config.security, null) != null ? { default = var.config.security } : {}
    content {
      enable_backend_ssl30                                = try(security.value.enable_backend_ssl30, false)
      enable_backend_tls10                                = try(security.value.enable_backend_tls10, false)
      enable_backend_tls11                                = try(security.value.enable_backend_tls11, false)
      enable_frontend_ssl30                               = try(security.value.enable_frontend_ssl30, false)
      enable_frontend_tls10                               = try(security.value.enable_frontend_tls10, false)
      enable_frontend_tls11                               = try(security.value.enable_frontend_tls11, false)
      tls_ecdhe_ecdsa_with_aes128_cbc_sha_ciphers_enabled = try(security.value.tls_ecdhe_ecdsa_with_aes128_cbc_sha_ciphers_enabled, false)
      tls_ecdhe_ecdsa_with_aes256_cbc_sha_ciphers_enabled = try(security.value.tls_ecdhe_ecdsa_with_aes256_cbc_sha_ciphers_enabled, false)
      tls_ecdhe_rsa_with_aes128_cbc_sha_ciphers_enabled   = try(security.value.tls_ecdhe_rsa_with_aes128_cbc_sha_ciphers_enabled, false)
      tls_ecdhe_rsa_with_aes256_cbc_sha_ciphers_enabled   = try(security.value.tls_ecdhe_rsa_with_aes256_cbc_sha_ciphers_enabled, false)
      tls_rsa_with_aes128_cbc_sha256_ciphers_enabled      = try(security.value.tls_rsa_with_aes128_cbc_sha256_ciphers_enabled, false)
      tls_rsa_with_aes128_cbc_sha_ciphers_enabled         = try(security.value.tls_rsa_with_aes128_cbc_sha_ciphers_enabled, false)
      tls_rsa_with_aes128_gcm_sha256_ciphers_enabled      = try(security.value.tls_rsa_with_aes128_gcm_sha256_ciphers_enabled, false)
      tls_rsa_with_aes256_gcm_sha384_ciphers_enabled      = try(security.value.tls_rsa_with_aes256_gcm_sha384_ciphers_enabled, false)
      tls_rsa_with_aes256_cbc_sha256_ciphers_enabled      = try(security.value.tls_rsa_with_aes256_cbc_sha256_ciphers_enabled, false)
      tls_rsa_with_aes256_cbc_sha_ciphers_enabled         = try(security.value.tls_rsa_with_aes256_cbc_sha_ciphers_enabled, false)
      triple_des_ciphers_enabled                          = try(security.value.triple_des_ciphers_enabled, false)
    }
  }

  dynamic "sign_in" {
    for_each = try(var.config.sign_in, null) != null ? { default = var.config.sign_in } : {}
    content {
      enabled = sign_in.value.enabled
    }
  }

  dynamic "sign_up" {
    for_each = try(var.config.sign_up, null) != null ? { default = var.config.sign_up } : {}
    content {
      enabled = sign_up.value.enabled
      dynamic "terms_of_service" {
        for_each = lookup(sign_up.value, "terms_of_service", null) != null ? [lookup(sign_up.value, "terms_of_service")] : []
        content {
          consent_required = terms_of_service.value.consent_required
          enabled          = terms_of_service.value.enabled
          text             = try(terms_of_service.value.text, null)
        }
      }
    }
  }

  dynamic "tenant_access" {
    for_each = try(var.config.tenant_access, null) != null ? { default = var.config.tenant_access } : {}
    content {
      enabled = tenant_access.value.enabled
    }
  }

  dynamic "virtual_network_configuration" {
    for_each = try(var.config.virtual_network_configuration, null) != null ? { default = var.config.virtual_network_configuration } : {}
    content {
      subnet_id = virtual_network_configuration.value.subnet_id
    }
  }

  tags = try(var.config.tags, var.tags)

}

resource "azurerm_user_assigned_identity" "identity" {
  for_each = lookup(var.config, "identity", null) != null ? (
    (lookup(var.config.identity, "type", null) == "UserAssigned" ||
    lookup(var.config.identity, "type", null) == "SystemAssigned, UserAssigned") &&
    lookup(var.config.identity, "identity_ids", null) == null ? { "identity" = var.config.identity } : {}
  ) : {}

  name                = try(each.value.name, "uai-${var.config.name}")
  resource_group_name = try(var.config.resource_group, var.resource_group)
  location            = try(var.config.location, var.location)
  tags                = try(each.value.tags, var.tags)
}

resource "azurerm_role_assignment" "apimcert" {
  for_each = lookup(var.config, "custom_domain", null) != null ? { default = var.config.custom_domain } : {}

  scope                = var.config.custom_domain.kvid
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = azurerm_api_management.apim.identity[0].principal_id
}

resource "azurerm_api_management_custom_domain" "apim" {
  for_each          = lookup(var.config, "custom_domain", null) != null ? { default = var.config.custom_domain } : {}
  api_management_id = azurerm_api_management.apim.id
  dynamic "management" {
    for_each = lookup(each.value, "management", null) != null ? [lookup(each.value, "management")] : []
    content {
      host_name                       = management.value.host_name
      key_vault_id                    = try(management.value.key_vault_id, null)
      certificate                     = try(management.value.certificate, null)
      certificate_password            = try(management.value.certificate_password, null)
      negotiate_client_certificate    = try(management.value.negotiate_client_certificate, false)
      ssl_keyvault_identity_client_id = try(management.value.ssl_keyvault_identity_client_id, null)
    }
  }

  dynamic "portal" {
    for_each = lookup(each.value, "portal", null) != null ? [lookup(each.value, "portal")] : []
    content {
      host_name                       = portal.value.host_name
      key_vault_id                    = try(portal.value.key_vault_id, null)
      certificate                     = try(portal.value.certificate, null)
      certificate_password            = try(portal.value.certificate_password, null)
      negotiate_client_certificate    = try(portal.value.negotiate_client_certificate, false)
      ssl_keyvault_identity_client_id = try(portal.value.ssl_keyvault_identity_client_id, null)
    }
  }

  dynamic "developer_portal" {
    for_each = lookup(each.value, "developer_portal", null) != null ? [lookup(each.value, "developer_portal")] : []
    content {
      host_name                       = developer_portal.value.host_name
      key_vault_id                    = try(developer_portal.value.key_vault_id, null)
      certificate                     = try(developer_portal.value.certificate, null)
      certificate_password            = try(developer_portal.value.certificate_password, null)
      negotiate_client_certificate    = try(developer_portal.value.negotiate_client_certificate, false)
      ssl_keyvault_identity_client_id = try(developer_portal.value.ssl_keyvault_identity_client_id, null)
    }
  }

  dynamic "gateway" {
    for_each = lookup(each.value, "gateway", null) != null ? [lookup(each.value, "gateway")] : []
    content {
      host_name                       = gateway.value.host_name
      key_vault_id                    = try(gateway.value.key_vault_id, null)
      certificate                     = try(gateway.value.certificate, null)
      certificate_password            = try(gateway.value.certificate_password, null)
      negotiate_client_certificate    = try(gateway.value.negotiate_client_certificate, false)
      ssl_keyvault_identity_client_id = try(gateway.value.ssl_keyvault_identity_client_id, null)
    }
  }

  dynamic "scm" {
    for_each = lookup(each.value, "scm", null) != null ? [lookup(each.value, "scm")] : []
    content {
      host_name                       = scm.value.host_name
      key_vault_id                    = try(scm.value.key_vault_id, null)
      certificate                     = try(scm.value.certificate, null)
      certificate_password            = try(scm.value.certificate_password, null)
      negotiate_client_certificate    = try(scm.value.negotiate_client_certificate, false)
      ssl_keyvault_identity_client_id = try(scm.value.ssl_keyvault_identity_client_id, null)
    }
  }
}

resource "azurerm_api_management_redis_cache" "apim" {
  for_each          = lookup(var.config, "redis_cache", null) != null ? { default = var.config.redis_cache } : {}
  name              = each.value.name
  api_management_id = azurerm_api_management.apim.id
  connection_string = each.value.connection_string
  description       = try(each.value.description, null)
  redis_cache_id    = try(each.value.redis_cache_id, null)
  cache_location    = try(each.value.cache_location, "default")
}

resource "azurerm_api_management_logger" "logger" {
  for_each            = lookup(var.config, "logger", null) != null ? { default = var.config.logger } : {}
  name                = each.value.name
  resource_group_name = coalesce(lookup(var.config, "resource_group", null), var.resource_group)
  api_management_name = azurerm_api_management.apim.name
  buffered            = try(each.value.buffered, true)
  description         = try(each.value.description, null)
  resource_id         = try(each.value.resource_id, null)

  dynamic "application_insights" {
    for_each = lookup(each.value, "application_insights", null) != null ? [lookup(each.value, "application_insights")] : []
    content {
      instrumentation_key = try(application_insights.value.instrumentation_key, null)
    }
  }

  dynamic "eventhub" {
    for_each = lookup(each.value, "eventhub", null) != null ? [lookup(each.value, "eventhub")] : []
    content {
      name                             = eventhub.value.name
      connection_string                = try(eventhub.value.connection_string, null)
      user_assigned_identity_client_id = try(eventhub.value.user_assigned_identity_client_id, null)
      endpoint_uri                     = try(eventhub.value.endpoint_uri, null)
    }
  }
}

resource "azurerm_api_management_api" "api" {
  for_each = {
    for key, api in lookup(var.config, "apis", {}) : key => api
  }

  name                  = each.value.name
  api_management_name   = azurerm_api_management.apim.name
  resource_group_name   = coalesce(lookup(var.config, "resource_group", null), var.resource_group)
  revision              = each.value.revision
  api_type              = try(each.value.api_type, "http")
  display_name          = try(each.value.display_name, null)
  path                  = try(each.value.path, null)
  protocols             = try(each.value.protocols, [])
  description           = try(each.value.description, null)
  service_url           = try(each.value.service_url, null)
  subscription_required = try(each.value.subscription_required, false)
  terms_of_service_url  = try(each.value.terms_of_service_url, null)
  version               = try(each.value.version, null)
  version_set_id        = try(each.value.version_set_id, null)
  revision_description  = try(each.value.revision_description, null)
  version_description   = try(each.value.version_description, null)
  source_api_id         = try(each.value.source_api_id, null)

  dynamic "contact" {
    for_each = lookup(each.value, "contact", null) != null ? [lookup(each.value, "contact")] : []
    content {
      email = try(contact.value.email, null)
      name  = try(contact.value.name, null)
      url   = try(contact.value.url, null)
    }
  }

  dynamic "import" {
    for_each = lookup(each.value, "import", null) != null ? [lookup(each.value, "import")] : []
    content {
      content_format = import.value.content_format
      content_value  = import.value.content_value
      dynamic "wsdl_selector" {
        for_each = lookup(import.value, "wsdl_selector", null) != null ? [lookup(import.value, "wsdl_selector")] : []
        content {
          service_name  = wsdl_selector.value.wsdl_service_name
          endpoint_name = wsdl_selector.value.wsdl_endpoint_name
        }
      }
    }
  }

  # dynamic "licence" {
  #   for_each = lookup(each.value, "licence", null) != null ? [lookup(each.value, "licence")] : []
  #   content {
  #     name = try(licence.value.name, null)
  #     url  = try(licence.value.url, null)
  #   }
  # }

  dynamic "oauth2_authorization" {
    for_each = lookup(each.value, "oauth2_authorization", null) != null ? [lookup(each.value, "oauth2_authorization")] : []
    content {
      authorization_server_name = oauth2_authorization.value.authorization_server_name
      scope                     = try(oauth2_authorization.value.scope, null)
    }
  }

  dynamic "openid_authentication" {
    for_each = lookup(each.value, "openid_authentication", null) != null ? [lookup(each.value, "openid_authentication")] : []
    content {
      openid_provider_name         = openid_authentication.value.openid_provider_name
      bearer_token_sending_methods = try(openid_authentication.value.bearer_token_sending_methods, [])
    }
  }

  dynamic "subscription_key_parameter_names" {
    for_each = lookup(each.value, "subscription_key_parameter_names", null) != null ? [lookup(each.value, "subscription_key_parameter_names")] : []
    content {
      header = subscription_key_parameter_names.value.header
      query  = subscription_key_parameter_names.value.query
    }
  }
}

#### WIP #####
resource "azurerm_api_management_identity_provider_aad" "provider" {
  for_each = lookup(var.config, "identity_provider_aad", null) != null ? { default = var.config.identity_provider_aad } : {}

  resource_group_name = coalesce(lookup(var.config, "resource_group", null), var.resource_group)
  api_management_name = azurerm_api_management.apim.name
  client_id           = each.value.client_id
  client_secret       = each.value.client_id
  allowed_tenants     = each.value.client_id
  client_library      = try(each.value.client_library, null)
  signin_tenant       = try(each.value.signin_tenant, null)
}

resource "azurerm_api_management_product" "product" {
  for_each = {
    for key, product in lookup(var.config, "products", {}) : key => product
  }

  api_management_name   = azurerm_api_management.apim.name
  resource_group_name   = coalesce(lookup(var.config, "resource_group", null), var.resource_group)
  approval_required     = try(each.value.approval_required, null)
  display_name          = each.value.display_name
  product_id            = each.value.product_id
  published             = try(each.value.published, null)
  subscription_required = try(each.value.subscription_required, true)
  description           = try(each.value.description, null)
  subscriptions_limit   = try(each.value.subscriptions_limit, null)
  terms                 = try(each.value.terms, null)
}

resource "azurerm_api_management_user" "user" {
  for_each = {
    for key, user in lookup(var.config, "users", {}) : key => user
  }

  api_management_name = azurerm_api_management.apim.name
  resource_group_name = coalesce(lookup(var.config, "resource_group", null), var.resource_group)
  email               = each.value.email
  first_name          = each.value.first_name
  last_name           = each.value.last_name
  user_id             = each.value.user_id
  confirmation        = try(each.value.confirmation, null)
  note                = try(each.value.note, null)
  password            = try(each.value.password, null)
  state               = try(each.value.state, null)
}