vault {
  address = "http://192.168.2.10:8200"

}
 ssl {
        enabled = true
        verify = false
    }
secret {
  no_prefix = true
 format = "secret_{{ key }}"
}