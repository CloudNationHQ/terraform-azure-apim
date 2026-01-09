# API Management Service

This terraform module streamlines the setup and management of the Azure API Management service, providing customizable configurations for an API Management service, as well as creating custom domains and application insights and Redis Cache integration.

## Goals

The main objective is to create a more logic data structure, achieved by combining and grouping related resources together in a complex object.

The structure of the module promotes reusability. It's intended to be a repeatable component, simplifying the process of building diverse workloads and platform accelerators consistently.

A primary goal is to utilize keys and values in the object that correspond to the REST API's structure. This enables us to carry out iterations, increasing its practical value as time goes on.

A last key goal is to separate logic from configuration in the module, thereby enhancing its scalability, ease of customization, and manageability.

## Non-Goals

These modules are not intended to be complete, ready-to-use solutions; they are designed as components for creating your own patterns.

They are not tailored for a single use case but are meant to be versatile and applicable to a range of scenarios.

Security standardization is applied at the pattern level, while the modules include default values based on best practices but do not enforce specific security standards.

End-to-end testing is not conducted on these modules, as they are individual components and do not undergo the extensive testing reserved for complete patterns or solutions.

## Features

- Create and manage API Management service
- Make use of custom domains for management, portal, developer portal and scm.
- Add API's
- Add an Application Insights instance for logging
- Add an Azure Cache for Redis for caching
- Add AAD Identity provider
- Add products and users

<!-- BEGIN_TF_DOCS -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.9.3)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (~> 4.0)

## Providers

The following providers are used by this module:

- <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) (~> 4.0)

## Resources

The following resources are used by this module:

- [azurerm_api_management.apim](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management) (resource)
- [azurerm_api_management_api.api](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_api) (resource)
- [azurerm_api_management_custom_domain.apim](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_custom_domain) (resource)
- [azurerm_api_management_identity_provider_aad.provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_identity_provider_aad) (resource)
- [azurerm_api_management_logger.logger](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_logger) (resource)
- [azurerm_api_management_product.product](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_product) (resource)
- [azurerm_api_management_redis_cache.apim](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_redis_cache) (resource)
- [azurerm_api_management_user.user](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/api_management_user) (resource)
- [azurerm_role_assignment.apimcert](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) (resource)

## Required Inputs

The following input variables are required:

### <a name="input_config"></a> [config](#input\_config)

Description: describes the apim configuration

Type:

```hcl
object({
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
```

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_location"></a> [location](#input\_location)

Description: default azure region to be used.

Type: `string`

Default: `null`

### <a name="input_naming"></a> [naming](#input\_naming)

Description: contains naming convention

Type: `map(string)`

Default: `{}`

### <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name)

Description: default resource group to be used.

Type: `string`

Default: `null`

### <a name="input_tags"></a> [tags](#input\_tags)

Description: tags to be added to the resources

Type: `map(string)`

Default: `{}`

## Outputs

The following outputs are exported:

### <a name="output_config"></a> [config](#output\_config)

Description: contains all redis cache configuration
<!-- END_TF_DOCS -->

## Goals

For more information, please see our [goals and non-goals](./GOALS.md).

## Testing

For more information, please see our testing [guidelines](./TESTING.md)

## Notes

Using a dedicated module, we've developed a naming convention for resources that's based on specific regular expressions for each type, ensuring correct abbreviations and offering flexibility with multiple prefixes and suffixes.

Full examples detailing all usages, along with integrations with dependency modules, are located in the examples directory.

To update the module's documentation run `make doc`

## Contributors

We welcome contributions from the community! Whether it's reporting a bug, suggesting a new feature, or submitting a pull request, your input is highly valued.

For more information, please see our contribution [guidelines](./CONTRIBUTING.md). <br><br>

<a href="https://github.com/cloudnationhq/terraform-azure-apim/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=cloudnationhq/terraform-azure-apim" />
</a>

## License

MIT Licensed. See [LICENSE](https://github.com/cloudnationhq/terraform-azure-apim/blob/main/LICENSE) for full details.

## References

- [Documentation](https://learn.microsoft.com/en-us/azure/api-management/)
- [Rest Api](https://learn.microsoft.com/en-us/rest/api/apimanagement/operation-groups?view=rest-apimanagement-2024-05-01)
- [Rest Api Specs](https://github.com/Azure/azure-rest-api-specs/tree/main/specification/apimanagement)
