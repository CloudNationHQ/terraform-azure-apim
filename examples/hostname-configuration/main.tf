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

module "kv" {
  source  = "cloudnationhq/kv/azure"
  version = "~> 6.0"

  vault = {
    name                = module.naming.key_vault.name_unique
    location            = module.rg.groups.demo.location
    resource_group_name = module.rg.groups.demo.name

    certs = local.certs
  }
}

module "uai" {
  source  = "cloudnationhq/uai/azure"
  version = "~> 3.0"

  identity = {
    name                = module.naming.user_assigned_identity.name
    location            = module.rg.groups.demo.location
    resource_group_name = module.rg.groups.demo.name
  }
}

resource "azurerm_role_assignment" "kv" {
  scope                = module.kv.vault.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = module.uai.identity.principal_id
}

module "apim" {
  source  = "cloudnationhq/apim/azure"
  version = "~> 4.0"

  service = local.apim

  depends_on = [azurerm_role_assignment.kv]
}
