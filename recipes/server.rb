include_recipe "#{cookbook_name}::_tls_keygen"

node.set['rsyslog']['additional_directives']['InputTCPServerStreamDriverPermittedPeer'] = "*.typo3.org"

include_recipe "rsyslog::server"

