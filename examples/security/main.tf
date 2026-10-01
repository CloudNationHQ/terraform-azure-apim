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

resource "tls_private_key" "ca" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "tls_self_signed_cert" "ca" {
  private_key_pem       = tls_private_key.ca.private_key_pem
  is_ca_certificate     = true
  validity_period_hours = 8760

  subject {
    common_name = "demo-root-ca"
  }

  allowed_uses = [
    "cert_signing",
    "crl_signing",
  ]
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

    protocols = {
      http2_enabled = true
    }

    security = {
      backend_ssl30_enabled                          = false
      backend_tls10_enabled                          = false
      backend_tls11_enabled                          = false
      frontend_ssl30_enabled                         = false
      frontend_tls10_enabled                         = false
      frontend_tls11_enabled                         = false
      triple_des_ciphers_enabled                     = false
      tls_rsa_with_aes128_gcm_sha256_ciphers_enabled = true
      tls_rsa_with_aes256_gcm_sha384_ciphers_enabled = true
    }

    tenant_access = {
      enabled = false
    }

    certificates = {
      root = {
        store_name = "Root"
        encoded_certificate = replace(
          trimspace(
            replace(
              replace(tls_self_signed_cert.ca.cert_pem, "-----BEGIN CERTIFICATE-----", ""),
              "-----END CERTIFICATE-----", ""
            )
          ), "\n", ""
        )
      }
    }
  }
}
