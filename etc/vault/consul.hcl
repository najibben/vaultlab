vault {
  address = "https://vault.service.consul:8200"
  token   = VAULT_TOKEN
  renew   = true

  ssl {
    enabled = false
    verify  = false
    cert    = "/path/to/client/cert.pem"
    ca_cert = "/path/to/ca/cert.pem"
  }
}