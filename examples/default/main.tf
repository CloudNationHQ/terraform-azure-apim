module "naming" {
  source  = "cloudnationhq/naming/azure"
  version = "~> 0.13"

  suffix = ["demo", "dev"]
}

module "rg" {
  source  = "cloudnationhq/rg/azure"
  version = "~> 2.0"

  groups = {
    demo = {
      name     = module.naming.resource_group.name
      location = "westeurope"
    }
  }
}

module "apim" {
  source  = "cloudnationhq/apim/azure"
  version = "~> 2.0"

  config = {
    name            = module.naming.api_management.name
    resource_group  = module.rg.groups.demo.name
    location        = module.rg.groups.demo.location
    sku_name        = "Developer_1"
    publisher_name  = "CloudNation"
    publisher_email = "testuser@cloudnation.nl"
  }
}
