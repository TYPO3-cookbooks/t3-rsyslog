#
# Cookbook Name:: rsyslog
# Recipe:: tls
#
# Copyright 2011, dkd Internet Service GmbH
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "rsyslog"

package "gnutls-bin"
package "rsyslog-gnutls"

if node['platform'] == 'debian' && node['lsb']['codename'] == 'jessie'
  package "libgnutls28-dev"
else
  package "libgnutls-dev"
end

# TODO ct 2011-11-16 Is there a nice way to make this OS independent?
directory "/etc/ssl/private/" do
  recursive true
  owner "root"
#  group "ssl-cert"
end

# Generate ca template
template "/etc/ssl/private/rsyslog-template.cfg" do
  source "ca-template.cfg.erb"
  mode "0664"
end


unless File.exists?("/etc/ssl/private/rsyslog-client-cert.pem") and File.exists?("/etc/ssl/private/rsyslog-client-key.pem")
  # Generate certificates for client + server
  ca_pki = data_bag_item("certificates", "rsyslog")

  file "/etc/ssl/private/rsyslog-ca.pem" do
    content ca_pki['ca_crt']
    mode "0644"
  end

  file "/etc/ssl/private/rsyslog-ca-key.pem" do
    content ca_pki['ca_key']
    mode "0400"
  end

  bash "Create rsyslog TLS client certificates" do
    cwd "/etc/ssl/private/"
    code <<-EOH
    umask 077
    certtool --generate-privkey --outfile rsyslog-client-key.pem --sec-param high
    certtool --generate-request --load-privkey rsyslog-client-key.pem --outfile request.pem --template rsyslog-template.cfg
    certtool --generate-certificate --load-request request.pem --outfile rsyslog-client-cert.pem --load-ca-certificate rsyslog-ca.pem --load-ca-privkey rsyslog-ca-key.pem --template rsyslog-template.cfg
    EOH
    notifies :restart, resources(:service => "rsyslog"), :delayed
  end

  # Cleanup root certificates (think security)
  %w{
    /etc/ssl/private/request.pem
    /etc/ssl/private/rsyslog-ca-key.pem
  }.each do |file|
    file "#{file}" do
      action :delete
      backup 0
    end
  end
end
