module "naming" {
  source  = "cloudnationhq/naming/azure"
  version = "~> 0.26"

  suffix = ["demo", "dev"]
}

module "rg" {
  source  = "cloudnationhq/rg/azure"
  version = "~> 2.0"

  groups = {
    demo = {
      name     = module.naming.resource_group.name_unique
      location = "westeurope"
    }
  }
}

module "vnet" {
  source  = "cloudnationhq/vnet/azure"
  version = "~> 9.0"

  vnet = {
    name                = module.naming.virtual_network.name
    location            = module.rg.groups.demo.location
    resource_group_name = module.rg.groups.demo.name
    address_space       = ["10.0.0.0/16"]
    subnets = {
      sn1 = {
        address_prefixes = ["10.0.0.0/24"]
        network_security_group = {
          rules = local.apim_nsg_rules
        }
      }
    }
  }
}

module "apim" {
  source  = "cloudnationhq/apim/azure"
  version = "~> 3.0"

  config = local.apim

  depends_on = [module.vnet]
}
