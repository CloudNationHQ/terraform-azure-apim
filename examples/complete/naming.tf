locals {
  naming = {
    # lookup outputs to have consistent naming
    for type in local.naming_types : type => lookup(module.naming, type).name
  }

  naming_types = ["api_management", "redis_cache", "subnet", "network_security_group", "virtual_network", "key_vault_secret", "key_vault_certificate", "key_vault",]
}