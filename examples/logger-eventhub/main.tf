module "naming" {
  source  = "cloudnationhq/naming/azure"
  version = "~> 0.26"

  suffix = ["demo", "dev"]
}

module "rg" {
  source  = "cloudnationhq/rg/azure"
  version = "~> 3.0"

  groups = {
    demo = {
      name     = module.naming.resource_group.name_unique
      location = "westeurope"
    }
  }
}

module "eventhub" {
  source  = "cloudnationhq/evh/azure"
  version = "~> 4.0"

  namespace = {
    name                = module.naming.eventhub_namespace.name_unique
    location            = module.rg.groups.demo.location
    resource_group_name = module.rg.groups.demo.name

    eventhubs = {
      apim = {
        authorization_rules = {
          send = {
            send = true
          }
        }
      }
    }
  }
}

module "apim" {
  source  = "cloudnationhq/apim/azure"
  version = "~> 4.0"

  service = {
    name                = module.naming.api_management.name_unique
    resource_group_name = module.rg.groups.demo.name
    location            = module.rg.groups.demo.location
    sku_name            = "Developer_1"
    publisher_name      = "CloudNation"
    publisher_email     = "testuser@cloudnation.nl"

    logger = {
      name        = "evh-logger"
      description = "event hub logger"
      buffered    = false

      eventhub = {
        name              = module.eventhub.eventhubs.apim.name
        connection_string = module.eventhub.authorization_rules["apim-send"].primary_connection_string
      }
    }
  }
}
