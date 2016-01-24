name             "t3-rsyslog"
maintainer       "TYPO3 Association"
maintainer_email "steffen.gebert@typo3.org"
license          "Apache 2.0"
description      "Customizatinos to rsyslog."
source_url       "https://github.com/typo3-cookbooks/t3-rsyslog"

version          "1.0.0"

recipe "t3-base::default",     "Default recipe, includes upstream and our recipes"
recipe "t3-base::_tls_keygen", "Generates client keys"

supports         "debian"

# TYPO3 cookbooks (pin to minor version: "~> a.b.0")

# Upstream cookbooks (pin to patch-level version: "= a.b.c")
depends "rsyslog",      "= 4.0.0"