locals {
  certs = {
    portal = {
      issuer             = "Self"
      subject            = "CN=apim.portal.example.com"
      validity_in_months = 12
      exportable         = true
      key_usage = [
        "cRLSign", "dataEncipherment",
        "digitalSignature", "keyAgreement",
        "keyCertSign", "keyEncipherment"
      ]
    }
    management = {
      issuer             = "Self"
      subject            = "CN=apim.management.example.com"
      validity_in_months = 12
      exportable         = true
      key_usage = [
        "cRLSign", "dataEncipherment",
        "digitalSignature", "keyAgreement",
        "keyCertSign", "keyEncipherment"
      ]
    }
  }
}

