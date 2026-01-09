resource "azurerm_api_management" "apim" {
  resource_group_name = coalesce(
    lookup(
      var.config, "resource_group_name", null
    ), var.resource_group_name
  )

  location = coalesce(
    lookup(
      var.config, "location", null
    ), var.location
  )

  name                          = var.config.name
  publisher_name                = var.config.publisher_name
  publisher_email               = var.config.publisher_email
  sku_name                      = var.config.sku_name
  client_certificate_enabled    = var.config.client_certificate_enabled
  gateway_disabled              = var.config.gateway_disabled
  min_api_version               = var.config.min_api_version
  zones                         = var.config.zones
  notification_sender_email     = var.config.notification_sender_email
  public_ip_address_id          = var.config.public_ip_address_id
  public_network_access_enabled = var.config.public_network_access_enabled
  virtual_network_type          = var.config.virtual_network_type

  dynamic "additional_location" {
    for_each = var.config.additional_locations

    content {
      location             = additional_location.value.location
      capacity             = additional_location.value.capacity
      zones                = additional_location.value.zones
      public_ip_address_id = additional_location.value.public_ip_address_id
      gateway_disabled     = additional_location.value.gateway_disabled

      dynamic "virtual_network_configuration" {
        for_each = additional_location.value.virtual_network_configuration != null ? [additional_location.value.virtual_network_configuration] : []

        content {
          subnet_id = virtual_network_configuration.value.subnet_id
        }
      }
    }
  }

  dynamic "certificate" {
    for_each = var.config.certificates

    content {
      encoded_certificate  = certificate.value.encoded_certificate
      store_name           = certificate.value.store_name
      certificate_password = certificate.value.certificate_password
    }
  }

  dynamic "delegation" {
    for_each = var.config.delegation != null ? [var.config.delegation] : []

    content {
      subscriptions_enabled     = delegation.value.subscriptions_enabled
      user_registration_enabled = delegation.value.user_registration_enabled
      url                       = delegation.value.url
      validation_key            = delegation.value.validation_key
    }
  }

  dynamic "hostname_configuration" {
    for_each = var.config.hostname_configuration != null ? [var.config.hostname_configuration] : []

    content {
      dynamic "management" {
        for_each = hostname_configuration.value.management

        content {
          host_name                       = management.value.host_name
          key_vault_certificate_id        = management.value.key_vault_certificate_id
          certificate                     = management.value.certificate
          certificate_password            = management.value.certificate_password
          negotiate_client_certificate    = management.value.negotiate_client_certificate
          ssl_keyvault_identity_client_id = management.value.ssl_keyvault_identity_client_id
        }
      }

      dynamic "portal" {
        for_each = hostname_configuration.value.portal

        content {
          host_name                       = portal.value.host_name
          key_vault_certificate_id        = portal.value.key_vault_certificate_id
          certificate                     = portal.value.certificate
          certificate_password            = portal.value.certificate_password
          negotiate_client_certificate    = portal.value.negotiate_client_certificate
          ssl_keyvault_identity_client_id = portal.value.ssl_keyvault_identity_client_id
        }
      }

      dynamic "developer_portal" {
        for_each = hostname_configuration.value.developer_portal

        content {
          host_name                       = developer_portal.value.host_name
          key_vault_certificate_id        = developer_portal.value.key_vault_certificate_id
          certificate                     = developer_portal.value.certificate
          certificate_password            = developer_portal.value.certificate_password
          negotiate_client_certificate    = developer_portal.value.negotiate_client_certificate
          ssl_keyvault_identity_client_id = developer_portal.value.ssl_keyvault_identity_client_id
        }
      }

      dynamic "proxy" {
        for_each = hostname_configuration.value.proxy

        content {
          default_ssl_binding             = proxy.value.default_ssl_binding
          host_name                       = proxy.value.host_name
          key_vault_certificate_id        = proxy.value.key_vault_certificate_id
          certificate                     = proxy.value.certificate
          certificate_password            = proxy.value.certificate_password
          negotiate_client_certificate    = proxy.value.negotiate_client_certificate
          ssl_keyvault_identity_client_id = proxy.value.ssl_keyvault_identity_client_id
        }
      }

      dynamic "scm" {
        for_each = hostname_configuration.value.scm

        content {
          host_name                       = scm.value.host_name
          key_vault_certificate_id        = scm.value.key_vault_certificate_id
          certificate                     = scm.value.certificate
          certificate_password            = scm.value.certificate_password
          negotiate_client_certificate    = scm.value.negotiate_client_certificate
          ssl_keyvault_identity_client_id = scm.value.ssl_keyvault_identity_client_id
        }
      }
    }
  }

  dynamic "identity" {
    for_each = var.config.identity != null ? [var.config.identity] : []

    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

  dynamic "protocols" {
    for_each = var.config.protocols != null ? [var.config.protocols] : []

    content {
      http2_enabled = protocols.value.http2_enabled
    }
  }

  dynamic "security" {
    for_each = var.config.security != null ? [var.config.security] : []

    content {
      backend_ssl30_enabled                               = security.value.backend_ssl30_enabled
      backend_tls10_enabled                               = security.value.backend_tls10_enabled
      backend_tls11_enabled                               = security.value.backend_tls11_enabled
      frontend_ssl30_enabled                              = security.value.frontend_ssl30_enabled
      frontend_tls10_enabled                              = security.value.frontend_tls10_enabled
      frontend_tls11_enabled                              = security.value.frontend_tls11_enabled
      tls_ecdhe_ecdsa_with_aes128_cbc_sha_ciphers_enabled = security.value.tls_ecdhe_ecdsa_with_aes128_cbc_sha_ciphers_enabled
      tls_ecdhe_ecdsa_with_aes256_cbc_sha_ciphers_enabled = security.value.tls_ecdhe_ecdsa_with_aes256_cbc_sha_ciphers_enabled
      tls_ecdhe_rsa_with_aes128_cbc_sha_ciphers_enabled   = security.value.tls_ecdhe_rsa_with_aes128_cbc_sha_ciphers_enabled
      tls_ecdhe_rsa_with_aes256_cbc_sha_ciphers_enabled   = security.value.tls_ecdhe_rsa_with_aes256_cbc_sha_ciphers_enabled
      tls_rsa_with_aes128_cbc_sha256_ciphers_enabled      = security.value.tls_rsa_with_aes128_cbc_sha256_ciphers_enabled
      tls_rsa_with_aes128_cbc_sha_ciphers_enabled         = security.value.tls_rsa_with_aes128_cbc_sha_ciphers_enabled
      tls_rsa_with_aes128_gcm_sha256_ciphers_enabled      = security.value.tls_rsa_with_aes128_gcm_sha256_ciphers_enabled
      tls_rsa_with_aes256_gcm_sha384_ciphers_enabled      = security.value.tls_rsa_with_aes256_gcm_sha384_ciphers_enabled
      tls_rsa_with_aes256_cbc_sha256_ciphers_enabled      = security.value.tls_rsa_with_aes256_cbc_sha256_ciphers_enabled
      tls_rsa_with_aes256_cbc_sha_ciphers_enabled         = security.value.tls_rsa_with_aes256_cbc_sha_ciphers_enabled
      triple_des_ciphers_enabled                          = security.value.triple_des_ciphers_enabled
    }
  }

  dynamic "sign_in" {
    for_each = var.config.sign_in != null ? [var.config.sign_in] : []

    content {
      enabled = sign_in.value.enabled
    }
  }

  dynamic "sign_up" {
    for_each = var.config.sign_up != null ? [var.config.sign_up] : []

    content {
      enabled = sign_up.value.enabled

      dynamic "terms_of_service" {
        for_each = sign_up.value.terms_of_service != null ? [sign_up.value.terms_of_service] : []

        content {
          consent_required = terms_of_service.value.consent_required
          enabled          = terms_of_service.value.enabled
          text             = terms_of_service.value.text
        }
      }
    }
  }

  dynamic "tenant_access" {
    for_each = var.config.tenant_access != null ? [var.config.tenant_access] : []

    content {
      enabled = tenant_access.value.enabled
    }
  }

  dynamic "virtual_network_configuration" {
    for_each = var.config.virtual_network_configuration != null ? [var.config.virtual_network_configuration] : []

    content {
      subnet_id = virtual_network_configuration.value.subnet_id
    }
  }

  tags = coalesce(
    var.config.tags, var.tags
  )
}

resource "azurerm_role_assignment" "apimcert" {
  for_each = var.config.custom_domain != null && lookup(var.config.custom_domain, "role_assignment", null) != null ? { default = var.config.custom_domain.role_assignment } : {}

  scope                                  = each.value.scope
  role_definition_id                     = each.value.role_definition_id
  role_definition_name                   = each.value.role_definition_name
  condition                              = each.value.condition
  condition_version                      = each.value.condition_version
  description                            = each.value.description
  name                                   = each.value.name
  skip_service_principal_aad_check       = each.value.skip_service_principal_aad_check
  principal_type                         = each.value.principal_type
  delegated_managed_identity_resource_id = each.value.delegated_managed_identity_resource_id
  principal_id                           = azurerm_api_management.apim.identity[0].principal_id
}

resource "azurerm_api_management_custom_domain" "apim" {
  for_each = var.config.custom_domain != null ? { default = var.config.custom_domain } : {}

  api_management_id = azurerm_api_management.apim.id

  dynamic "management" {
    for_each = each.value.management

    content {
      host_name                       = management.value.host_name
      key_vault_certificate_id        = management.value.key_vault_certificate_id
      certificate                     = management.value.certificate
      certificate_password            = management.value.certificate_password
      negotiate_client_certificate    = management.value.negotiate_client_certificate
      ssl_keyvault_identity_client_id = management.value.ssl_keyvault_identity_client_id
    }
  }

  dynamic "portal" {
    for_each = each.value.portal

    content {
      host_name                       = portal.value.host_name
      key_vault_certificate_id        = portal.value.key_vault_certificate_id
      certificate                     = portal.value.certificate
      certificate_password            = portal.value.certificate_password
      negotiate_client_certificate    = portal.value.negotiate_client_certificate
      ssl_keyvault_identity_client_id = portal.value.ssl_keyvault_identity_client_id
    }
  }

  dynamic "developer_portal" {
    for_each = each.value.developer_portal

    content {
      host_name                       = developer_portal.value.host_name
      key_vault_certificate_id        = developer_portal.value.key_vault_certificate_id
      certificate                     = developer_portal.value.certificate
      certificate_password            = developer_portal.value.certificate_password
      negotiate_client_certificate    = developer_portal.value.negotiate_client_certificate
      ssl_keyvault_identity_client_id = developer_portal.value.ssl_keyvault_identity_client_id
    }
  }

  dynamic "gateway" {
    for_each = each.value.gateway

    content {
      host_name                       = gateway.value.host_name
      key_vault_certificate_id        = gateway.value.key_vault_certificate_id
      certificate                     = gateway.value.certificate
      certificate_password            = gateway.value.certificate_password
      negotiate_client_certificate    = gateway.value.negotiate_client_certificate
      ssl_keyvault_identity_client_id = gateway.value.ssl_keyvault_identity_client_id
      default_ssl_binding             = gateway.value.default_ssl_binding
    }
  }

  dynamic "scm" {
    for_each = each.value.scm

    content {
      host_name                       = scm.value.host_name
      key_vault_certificate_id        = scm.value.key_vault_certificate_id
      certificate                     = scm.value.certificate
      certificate_password            = scm.value.certificate_password
      negotiate_client_certificate    = scm.value.negotiate_client_certificate
      ssl_keyvault_identity_client_id = scm.value.ssl_keyvault_identity_client_id
    }
  }
}

resource "azurerm_api_management_redis_cache" "apim" {
  for_each = nonsensitive(var.config.redis_cache != null ? { default = var.config.redis_cache } : {})

  name              = each.value.name
  api_management_id = azurerm_api_management.apim.id
  connection_string = each.value.connection_string
  description       = each.value.description
  redis_cache_id    = each.value.redis_cache_id
  cache_location    = each.value.cache_location
}

resource "azurerm_api_management_logger" "logger" {
  for_each = nonsensitive(var.config.logger != null ? { default = var.config.logger } : {})

  resource_group_name = coalesce(
    var.config.resource_group_name, var.resource_group_name
  )

  name                = each.value.name
  api_management_name = azurerm_api_management.apim.name
  buffered            = each.value.buffered
  description         = each.value.description
  resource_id         = each.value.resource_id

  dynamic "application_insights" {
    for_each = each.value.application_insights != null ? [each.value.application_insights] : []

    content {
      instrumentation_key = application_insights.value.instrumentation_key
    }
  }

  dynamic "eventhub" {
    for_each = each.value.eventhub != null ? [each.value.eventhub] : []

    content {
      name                             = eventhub.value.name
      connection_string                = eventhub.value.connection_string
      user_assigned_identity_client_id = eventhub.value.user_assigned_identity_client_id
      endpoint_uri                     = eventhub.value.endpoint_uri
    }
  }
}

resource "azurerm_api_management_api" "api" {
  for_each = var.config.apis

  name                  = each.value.name
  api_management_name   = azurerm_api_management.apim.name
  resource_group_name   = coalesce(var.config.resource_group_name, var.resource_group_name)
  revision              = each.value.revision
  api_type              = each.value.api_type
  display_name          = each.value.display_name
  path                  = each.value.path
  protocols             = each.value.protocols
  description           = each.value.description
  service_url           = each.value.service_url
  subscription_required = each.value.subscription_required
  terms_of_service_url  = each.value.terms_of_service_url
  version               = each.value.version
  version_set_id        = each.value.version_set_id
  revision_description  = each.value.revision_description
  version_description   = each.value.version_description
  source_api_id         = each.value.source_api_id

  dynamic "contact" {
    for_each = each.value.contact != null ? [each.value.contact] : []

    content {
      email = contact.value.email
      name  = contact.value.name
      url   = contact.value.url
    }
  }

  dynamic "license" {
    for_each = each.value.license != null ? [each.value.license] : []

    content {
      name = license.value.name
      url  = license.value.url
    }
  }

  dynamic "import" {
    for_each = each.value.import != null ? [each.value.import] : []

    content {
      content_format = import.value.content_format
      content_value  = import.value.content_value

      dynamic "wsdl_selector" {
        for_each = import.value.wsdl_selector != null ? [import.value.wsdl_selector] : []

        content {
          service_name  = wsdl_selector.value.wsdl_service_name
          endpoint_name = wsdl_selector.value.wsdl_endpoint_name
        }
      }
    }
  }

  dynamic "oauth2_authorization" {
    for_each = each.value.oauth2_authorization != null ? [each.value.oauth2_authorization] : []

    content {
      authorization_server_name = oauth2_authorization.value.authorization_server_name
      scope                     = oauth2_authorization.value.scope
    }
  }

  dynamic "openid_authentication" {
    for_each = each.value.openid_authentication != null ? [each.value.openid_authentication] : []

    content {
      openid_provider_name         = openid_authentication.value.openid_provider_name
      bearer_token_sending_methods = openid_authentication.value.bearer_token_sending_methods
    }
  }

  dynamic "subscription_key_parameter_names" {
    for_each = each.value.subscription_key_parameter_names != null ? [each.value.subscription_key_parameter_names] : []

    content {
      header = subscription_key_parameter_names.value.header
      query  = subscription_key_parameter_names.value.query
    }
  }
}

resource "azurerm_api_management_identity_provider_aad" "provider" {
  for_each = var.config.identity_provider_aad != null ? { default = var.config.identity_provider_aad } : {}

  resource_group_name = coalesce(
    lookup(
      var.config, "resource_group_name", null
    ), var.resource_group_name
  )

  api_management_name = azurerm_api_management.apim.name
  client_id           = each.value.client_id
  client_secret       = each.value.client_secret
  allowed_tenants     = each.value.allowed_tenants
  client_library      = each.value.client_library
  signin_tenant       = each.value.signin_tenant
}

resource "azurerm_api_management_product" "product" {
  for_each = var.config.products

  resource_group_name = coalesce(
    lookup(
      var.config, "resource_group_name", null
    ), var.resource_group_name
  )

  api_management_name   = azurerm_api_management.apim.name
  approval_required     = each.value.approval_required
  display_name          = each.value.display_name
  product_id            = each.value.product_id
  published             = each.value.published
  subscription_required = each.value.subscription_required
  description           = each.value.description
  subscriptions_limit   = each.value.subscriptions_limit
  terms                 = each.value.terms
}

resource "azurerm_api_management_user" "user" {
  for_each = var.config.users

  resource_group_name = coalesce(
    lookup(
      var.config, "resource_group_name", null
    ), var.resource_group_name
  )

  api_management_name = azurerm_api_management.apim.name
  email               = each.value.email
  first_name          = each.value.first_name
  last_name           = each.value.last_name
  user_id             = each.value.user_id
  confirmation        = each.value.confirmation
  note                = each.value.note
  password            = each.value.password
  state               = each.value.state
}
