locals {
  naming = {
    for type in local.naming_types : type => lookup(module.naming, type).name
  }

  naming_types = [
    "api_management",
    "key_vault",
    "key_vault_certificate",
    "key_vault_secret",
    "user_assigned_identity",
  ]
}

