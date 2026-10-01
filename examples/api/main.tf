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

    apis = {
      echo = {
        revision     = "1"
        display_name = "Echo API"
        path         = "echo"
        protocols    = ["https"]
        service_url  = "https://httpbin.org"
      }

      petstore = {
        revision             = "1"
        display_name         = "Petstore API"
        path                 = "petstore"
        protocols            = ["https"]
        terms_of_service_url = "https://example.com/terms"

        contact = {
          name  = "CloudNation"
          email = "testuser@cloudnation.nl"
          url   = "https://www.cloudnation.nl"
        }

        license = {
          name = "MIT"
          url  = "https://opensource.org/licenses/MIT"
        }

        subscription_key_parameter_names = {
          header = "X-Api-Key"
          query  = "api-key"
        }

        import = {
          content_format = "openapi+json"
          content_value  = file("${path.module}/openapi.json")
        }
      }

      calculator = {
        revision     = "1"
        display_name = "Calculator API"
        path         = "calculator"
        protocols    = ["https"]
        api_type     = "soap"

        import = {
          content_format = "wsdl"
          content_value  = file("${path.module}/calculator.wsdl")

          wsdl_selector = {
            wsdl_service_name  = "Calculator"
            wsdl_endpoint_name = "CalculatorSoap"
          }
        }
      }
    }
  }
}

