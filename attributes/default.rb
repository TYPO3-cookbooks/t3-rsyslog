#<> Search query to find the Rsyslog server
default['rsyslog']['server_search']        = "role:rsyslog_server"
#<> Enable TLS connection
default['rsyslog']['enable_tls']           = true
#<> Path to TLS CA file
default['rsyslog']['tls_ca_file']          = "/etc/ssl/private/rsyslog-ca.pem"
#<> Path to TLS certificate file
default['rsyslog']['tls_certificate_file'] = "/etc/ssl/private/rsyslog-client-cert.pem"
#<> Path to TLS key file
default['rsyslog']['tls_key_file']         =  "/etc/ssl/private/rsyslog-client-key.pem"
#<> Use x509 certificates for authentication (sets `$InputTCPServerStreamDriverAuthMode`/`$ActionSendStreamDriverAuthMode`)
default['rsyslog']['tls_auth_mode'] = "x509/name"
#<> Preserve FQDN
default['rsyslog']['preserve_fqdn'] = "on"
#<> Collect logs on the server in `/var/log/rsyslog`
default['rsyslog']['log_dir'] = "/var/log/rsyslog"