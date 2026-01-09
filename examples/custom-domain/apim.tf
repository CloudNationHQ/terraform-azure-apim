locals {
  apim = {
    name                = module.naming.api_management.name_unique
    resource_group_name = module.rg.groups.demo.name
    location            = module.rg.groups.demo.location
    sku_name            = "Developer_1"
    publisher_name      = "CloudNation"
    publisher_email     = "testuser@cloudnation.nl"

    identity = {
      type         = "SystemAssigned, UserAssigned"
      identity_ids = [module.uai.config.id]
    }

    custom_domain = {
      role_assignment = {
        scope = module.kv.vault.id
      }

      portal = {
        portal1 = {
          host_name                = "apim.portal.example.com"
          key_vault_certificate_id = module.kv.certs.portal.versionless_secret_id
        }
      }

      management = {
        mgmt1 = {
          host_name                = "apim.management.example.com"
          key_vault_certificate_id = module.kv.certs.management.versionless_secret_id
        }
      }
    }
  }
}

