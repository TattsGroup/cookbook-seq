#
# Cookbook Name:: seq
# Recipe:: license
#
# Copyright (c) 2016 Tatts Group, All Rights Reserved.

unless node['seq']['license'].nil?
  require 'base64'
  require 'json'

  license = ::Base64.decode64(node['seq']['license'])
  payload = { Id: 'license-server', LicenseText: license }
  json_payload = JSON.generate(payload)

  json_current_license = Chef::HTTP.new('http://localhost:5341').get('/api/licenses/license-server')
  current_license = JSON.parse(json_current_license)
  new_license = JSON.parse(json_payload)

  http_request 'load seq license' do
    headers('Content-type' => 'application/json')
    message JSON.generate(payload)
    url 'http://localhost:5341/api/licenses/license-server'
    action :put
    not_if { new_license['LicenseText'].to_s == current_license['LicenseText'].to_s }
  end
end
