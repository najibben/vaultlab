storage "consul" {
  address = "127.0.0.1:8500"
  path    = "vault"

}

listener "tcp" {
  #address          = "127.0.0.1:8200"
  address          = "192.168.2.14:8200"
  cluster_address  = "192.168.2.14:8201"
  #tls_disable      = "true"
  tls_cert_file = "/vagrant/etc/vault/mydomain.com.crt"
  tls_key_file = "/vagrant/etc/vault/mydomain.com.key"
  tls_client_ca_file = "/vagrant/etc/vault/mydomain.com.crt"
  
}



api_addr = "https://192.168.2.14:8200"
cluster_addr = "https://192.168.2.14:8201"
plugin_directory = "/vagrant/plugins/"
ui = true
disable_performance_standby = 1





