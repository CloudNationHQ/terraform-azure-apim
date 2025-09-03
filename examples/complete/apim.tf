locals {
  apim = {
    name                 = module.naming.api_management.name_unique
    resource_group       = module.rg.groups.demo.name
    location             = module.rg.groups.demo.location
    sku_name             = "Developer_1"
    publisher_name       = "CloudNation"
    publisher_email      = "testuser@cloudnation.nl"
    virtual_network_type = "Internal"

    custom_domain = {
      kvid = module.kv.vault.id
      portal = {
        host_name                = "apim.portal.example.com"
        key_vault_certificate_id = module.kv.certs.portal.versionless_secret_id
      }
      management = {
        host_name                = "apim.management.example.com"
        key_vault_certificate_id = module.kv.certs.management.versionless_secret_id
      }
    }

    identity = {
      type = "SystemAssigned, UserAssigned"
    }

    virtual_network_configuration = {
      subnet_id = module.vnet.subnets.sn1.id
    }

    protocols = {
      enable_http2 = true
    }

    redis_cache = {
      name              = module.redis.cache.name
      connection_string = module.redis.cache.primary_connection_string
    }

    logger = {
      name = module.appi.config.name
      application_insights = {
        instrumentation_key = module.appi.config.instrumentation_key
      }
    }
  }
}
