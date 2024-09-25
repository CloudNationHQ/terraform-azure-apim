terraform {
  required_version = ">= 1.9.3"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {
    # Added as Application Insights is not deleting an Action Group which disallows terraform the deletion of the resource group
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}
