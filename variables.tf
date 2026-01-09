variable "config" {
  description = "describes the apim configuration"
  type = object({
    name                          = string
    resource_group_name           = optional(string)
    location                      = optional(string)
    publisher_name                = string
    publisher_email               = string
    sku_name                      = string
    client_certificate_enabled    = optional(bool)
    gateway_disabled              = optional(bool)
    min_api_version               = optional(string)
    zones                         = optional(list(string))
    notification_sender_email     = optional(string)
    public_ip_address_id          = optional(string)
    public_network_access_enabled = optional(bool)
    virtual_network_type          = optional(string, "None")
    tags                          = optional(map(string))
    additional_locations = optional(map(object({
      location             = string
      capacity             = optional(number)
      zones                = optional(list(string))
      public_ip_address_id = optional(string)
      gateway_disabled     = optional(bool, false)
      virtual_network_configuration = optional(object({
        subnet_id = string
      }))
    })), {})
    certificates = optional(map(object({
      encoded_certificate  = string
      store_name           = string
      certificate_password = optional(string)
    })), {})
    delegation = optional(object({
      subscriptions_enabled     = optional(bool, false)
      user_registration_enabled = optional(bool, false)
      url                       = optional(string)
      validation_key            = optional(string)
    }))
    hostname_configuration = optional(object({
      management = optional(map(object({
        host_name                       = string
        key_vault_certificate_id        = optional(string)
        certificate                     = optional(string)
        certificate_password            = optional(string)
        negotiate_client_certificate    = optional(bool, false)
        ssl_keyvault_identity_client_id = optional(string)
      })), {})
      portal = optional(map(object({
        host_name                       = string
        key_vault_certificate_id        = optional(string)
        certificate                     = optional(string)
        certificate_password            = optional(string)
        negotiate_client_certificate    = optional(bool, false)
        ssl_keyvault_identity_client_id = optional(string)
      })), {})
      developer_portal = optional(map(object({
        host_name                       = string
        key_vault_certificate_id        = optional(string)
        certificate                     = optional(string)
        certificate_password            = optional(string)
        negotiate_client_certificate    = optional(bool, false)
        ssl_keyvault_identity_client_id = optional(string)
      })), {})
      proxy = optional(map(object({
        default_ssl_binding             = optional(bool, false)
        host_name                       = string
        key_vault_certificate_id        = optional(string)
        certificate                     = optional(string)
        certificate_password            = optional(string)
        negotiate_client_certificate    = optional(bool, false)
        ssl_keyvault_identity_client_id = optional(string)
      })), {})
      scm = optional(map(object({
        host_name                       = string
        key_vault_certificate_id        = optional(string)
        certificate                     = optional(string)
        certificate_password            = optional(string)
        negotiate_client_certificate    = optional(bool, false)
        ssl_keyvault_identity_client_id = optional(string)
      })), {})
    }))
    identity = optional(object({
      type         = string
      identity_ids = optional(list(string))
      name         = optional(string)
      tags         = optional(map(string))
    }))
    protocols = optional(object({
      http2_enabled = optional(bool, false)
    }))
    security = optional(object({
      backend_ssl30_enabled                               = optional(bool, false)
      backend_tls10_enabled                               = optional(bool, false)
      backend_tls11_enabled                               = optional(bool, false)
      frontend_ssl30_enabled                              = optional(bool, false)
      frontend_tls10_enabled                              = optional(bool, false)
      frontend_tls11_enabled                              = optional(bool, false)
      tls_ecdhe_ecdsa_with_aes128_cbc_sha_ciphers_enabled = optional(bool, false)
      tls_ecdhe_ecdsa_with_aes256_cbc_sha_ciphers_enabled = optional(bool, false)
      tls_ecdhe_rsa_with_aes128_cbc_sha_ciphers_enabled   = optional(bool, false)
      tls_ecdhe_rsa_with_aes256_cbc_sha_ciphers_enabled   = optional(bool, false)
      tls_rsa_with_aes128_cbc_sha256_ciphers_enabled      = optional(bool, false)
      tls_rsa_with_aes128_cbc_sha_ciphers_enabled         = optional(bool, false)
      tls_rsa_with_aes128_gcm_sha256_ciphers_enabled      = optional(bool, false)
      tls_rsa_with_aes256_gcm_sha384_ciphers_enabled      = optional(bool, false)
      tls_rsa_with_aes256_cbc_sha256_ciphers_enabled      = optional(bool, false)
      tls_rsa_with_aes256_cbc_sha_ciphers_enabled         = optional(bool, false)
      triple_des_ciphers_enabled                          = optional(bool, false)
    }))
    sign_in = optional(object({
      enabled = bool
    }))
    sign_up = optional(object({
      enabled = bool
      terms_of_service = optional(object({
        consent_required = bool
        enabled          = bool
        text             = optional(string)
      }))
    }))
    tenant_access = optional(object({
      enabled = bool
    }))
    virtual_network_configuration = optional(object({
      subnet_id = string
    }))
    custom_domain = optional(object({
      role_assignment = optional(object({
        scope                                  = string
        role_definition_id                     = optional(string)
        role_definition_name                   = optional(string, "Key Vault Secrets Officer")
        condition                              = optional(string)
        condition_version                      = optional(string)
        description                            = optional(string)
        name                                   = optional(string)
        skip_service_principal_aad_check       = optional(bool)
        principal_type                         = optional(string)
        delegated_managed_identity_resource_id = optional(string)
      }))
      management = optional(map(object({
        host_name                       = string
        key_vault_certificate_id        = optional(string)
        certificate                     = optional(string)
        certificate_password            = optional(string)
        negotiate_client_certificate    = optional(bool, false)
        ssl_keyvault_identity_client_id = optional(string)
      })), {})
      portal = optional(map(object({
        host_name                       = string
        key_vault_certificate_id        = optional(string)
        certificate                     = optional(string)
        certificate_password            = optional(string)
        negotiate_client_certificate    = optional(bool, false)
        ssl_keyvault_identity_client_id = optional(string)
      })), {})
      developer_portal = optional(map(object({
        host_name                       = string
        key_vault_certificate_id        = optional(string)
        certificate                     = optional(string)
        certificate_password            = optional(string)
        negotiate_client_certificate    = optional(bool, false)
        ssl_keyvault_identity_client_id = optional(string)
      })), {})
      gateway = optional(map(object({
        host_name                       = string
        key_vault_certificate_id        = optional(string)
        certificate                     = optional(string)
        certificate_password            = optional(string)
        negotiate_client_certificate    = optional(bool, false)
        ssl_keyvault_identity_client_id = optional(string)
        default_ssl_binding             = optional(bool, false)
      })), {})
      scm = optional(map(object({
        host_name                       = string
        key_vault_certificate_id        = optional(string)
        certificate                     = optional(string)
        certificate_password            = optional(string)
        negotiate_client_certificate    = optional(bool, false)
        ssl_keyvault_identity_client_id = optional(string)
      })), {})
    }))
    redis_cache = optional(object({
      name              = string
      connection_string = string
      description       = optional(string)
      redis_cache_id    = optional(string)
      cache_location    = optional(string, "default")
    }))
    logger = optional(object({
      name        = string
      buffered    = optional(bool, true)
      description = optional(string)
      resource_id = optional(string)
      application_insights = optional(object({
        instrumentation_key = string
      }))
      eventhub = optional(object({
        name                             = string
        connection_string                = optional(string)
        user_assigned_identity_client_id = optional(string)
        endpoint_uri                     = optional(string)
      }))
    }))
    apis = optional(map(object({
      name                  = string
      revision              = string
      api_type              = optional(string, "http")
      display_name          = optional(string)
      path                  = optional(string)
      protocols             = optional(list(string), [])
      description           = optional(string)
      service_url           = optional(string)
      subscription_required = optional(bool, false)
      terms_of_service_url  = optional(string)
      version               = optional(string)
      version_set_id        = optional(string)
      revision_description  = optional(string)
      version_description   = optional(string)
      source_api_id         = optional(string)
      contact = optional(object({
        email = optional(string)
        name  = optional(string)
        url   = optional(string)
      }))
      license = optional(object({
        name = optional(string)
        url  = optional(string)
      }))
      import = optional(object({
        content_format = string
        content_value  = string
        wsdl_selector = optional(object({
          wsdl_service_name  = string
          wsdl_endpoint_name = string
        }))
      }))
      oauth2_authorization = optional(object({
        authorization_server_name = string
        scope                     = optional(string)
      }))
      openid_authentication = optional(object({
        openid_provider_name         = string
        bearer_token_sending_methods = optional(list(string), [])
      }))
      subscription_key_parameter_names = optional(object({
        header = string
        query  = string
      }))
    })), {})
    identity_provider_aad = optional(object({
      client_id       = string
      client_secret   = string
      allowed_tenants = list(string)
      client_library  = optional(string)
      signin_tenant   = optional(string)
    }))
    products = optional(map(object({
      display_name          = string
      product_id            = string
      approval_required     = optional(bool)
      published             = optional(bool)
      subscription_required = optional(bool, true)
      description           = optional(string)
      subscriptions_limit   = optional(number)
      terms                 = optional(string)
    })), {})
    users = optional(map(object({
      email        = string
      first_name   = string
      last_name    = string
      user_id      = string
      confirmation = optional(string)
      note         = optional(string)
      password     = optional(string)
      state        = optional(string)
    })), {})
  })

  validation {
    condition     = var.config.location != null || var.location != null
    error_message = "location must be provided either in the config object or as a separate variable."
  }

  validation {
    condition     = var.config.resource_group_name != null || var.resource_group_name != null
    error_message = "resource group name must be provided either in the config object or as a separate variable."
  }
}

variable "naming" {
  description = "contains naming convention"
  type        = map(string)
  default     = {}
}

variable "location" {
  description = "default azure region to be used."
  type        = string
  default     = null
}

variable "resource_group_name" {
  description = "default resource group to be used."
  type        = string
  default     = null
}

variable "tags" {
  description = "tags to be added to the resources"
  type        = map(string)
  default     = {}
}
