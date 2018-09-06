vault {
  address = "http://192.168.2.10:8200"
  token   = "6212da45-329e-814c-2200-faa8973a8b33"
}
 ssl {
        enabled = true
        verify = false
    }
secret {
  no_prefix = true
  path      = "kv/password"
 format = "secret_{{ key }}"
}