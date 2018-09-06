
storage "gcs" {

ui = true
}

listener "tcp" {
  address                  = "192.168.2.10:8200"
  tls_cert_file            = "/etc/vault/server.crt"
  tls_key_file             = "/etc/vault/server.key"
  tls_disable_client_certs = true
  tls_disable              = true
}
