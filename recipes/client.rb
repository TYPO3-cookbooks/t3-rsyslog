#
# Cookbook Name:: t3-rsyslog
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

include_recipe "#{cookbook_name}::_tls_keygen"

include_recipe "rsyslog::client"

