locals {
  apim_nsg_rules = {
    100 = {
      name                       = "allow-443-from-internet-to-apim"
      priority                   = 100
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "443"
      source_address_prefix      = "Internet"
      destination_address_prefix = "VirtualNetwork"
    }

    110 = {
      name                       = "allow-3443-from-apim-to-vnet"
      priority                   = 110
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "3443"
      source_address_prefix      = "ApiManagement"
      destination_address_prefix = "VirtualNetwork"
    }

    120 = {
      name                       = "allow-6390-from-azurelb-to-vnet"
      priority                   = 120
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = "6390"
      source_address_prefix      = "ApiManagement"
      destination_address_prefix = "VirtualNetwork"
    }
  }
}