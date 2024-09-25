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

module "vnet" {
  source  = "cloudnationhq/vnet/azure"
  version = "~> 4.0"

  naming = local.naming

  vnet = {
    name           = module.naming.virtual_network.name
    location       = module.rg.groups.demo.location
    resource_group = module.rg.groups.demo.name
    cidr           = ["10.0.0.0/16"]
    subnets = {
      sn1 = {
        cidr = ["10.0.0.0/24"]
        nsg = {
          rules = local.apim_nsg_rules
        }
      }
    }
  }
}

module "kv" {
  source  = "cloudnationhq/kv/azure"
  version = "~> 2.0"

  naming = local.naming

  vault = {
    name           = module.naming.key_vault.name_unique
    location       = module.rg.groups.demo.location
    resource_group = module.rg.groups.demo.name

    certs = local.certs
  }
}

module "redis" {
  source  = "cloudnationhq/redis/azure"
  version = "~> 2.0"

  cache = {
    name           = module.naming.redis_cache.name
    resource_group = module.rg.groups.demo.name
    location       = module.rg.groups.demo.location
    sku_name       = "Basic"
    capacity       = 1
    family         = "C"
  }
}

module "appi" {
  source  = "cloudnationhq/appi/azure"
  version = "~> 2.0"

  config = {
    name             = module.naming.application_insights.name
    resource_group   = module.rg.groups.demo.name
    location         = module.rg.groups.demo.location
    application_type = "web"
  }
}

module "apim" {
  source  = "cloudnationhq/apim/azure"
  version = "~> 2.0"

  config = local.apim
}
