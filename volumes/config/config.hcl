storage "file" {
  path    = "./volumes/file"
}

listener "tcp" {
  address     = "0.0.0.0:443"
  tls_disable = "false"
  tls_cert_file = "/vault/cert/vault.crt"
  tls_key_file  = "/vault/cert/vault.key"
}

disable_mlock = true

ui = true