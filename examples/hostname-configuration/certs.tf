locals {
  certs = {
    management = {
      issuer             = "Self"
      subject            = "CN=apim.management.example.com"
      validity_in_months = 12
      exportable         = true
      key_type           = "RSA"
      key_size           = 2048
      reuse_key          = false
      content_type       = "application/x-pkcs12"
      key_usage = [
        "cRLSign", "dataEncipherment",
        "digitalSignature", "keyAgreement",
        "keyCertSign", "keyEncipherment"
      ]
    }

    portal = {
      issuer             = "Self"
      subject            = "CN=apim.portal.example.com"
      validity_in_months = 12
      exportable         = true
      key_type           = "RSA"
      key_size           = 2048
      reuse_key          = false
      content_type       = "application/x-pkcs12"
      key_usage = [
        "cRLSign", "dataEncipherment",
        "digitalSignature", "keyAgreement",
        "keyCertSign", "keyEncipherment"
      ]
    }

    developer = {
      issuer             = "Self"
      subject            = "CN=apim.developer.example.com"
      validity_in_months = 12
      exportable         = true
      key_type           = "RSA"
      key_size           = 2048
      reuse_key          = false
      content_type       = "application/x-pkcs12"
      key_usage = [
        "cRLSign", "dataEncipherment",
        "digitalSignature", "keyAgreement",
        "keyCertSign", "keyEncipherment"
      ]
    }

    proxy = {
      issuer             = "Self"
      subject            = "CN=apim.proxy.example.com"
      validity_in_months = 12
      exportable         = true
      key_type           = "RSA"
      key_size           = 2048
      reuse_key          = false
      content_type       = "application/x-pkcs12"
      key_usage = [
        "cRLSign", "dataEncipherment",
        "digitalSignature", "keyAgreement",
        "keyCertSign", "keyEncipherment"
      ]
    }

    scm = {
      issuer             = "Self"
      subject            = "CN=apim.scm.example.com"
      validity_in_months = 12
      exportable         = true
      key_type           = "RSA"
      key_size           = 2048
      reuse_key          = false
      content_type       = "application/x-pkcs12"
      key_usage = [
        "cRLSign", "dataEncipherment",
        "digitalSignature", "keyAgreement",
        "keyCertSign", "keyEncipherment"
      ]
    }
  }
}
