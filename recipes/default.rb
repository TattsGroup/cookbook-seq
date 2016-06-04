#
# Cookbook Name:: seq
# Recipe:: default
#
# Copyright (c) 2016 Tatts Group, All Rights Reserved.

require 'win32/service' if RUBY_PLATFORM =~ /mswin|mingw32|windows/

reboot 'now' do
  action :nothing
  reason 'Cannot continue Chef run without a reboot.'
end

ms_dotnet_framework '4.5.2' do
  action            :install
  package_sources   node['ms_dotnet']['v4']['package_sources']
  notifies :reboot_now, 'reboot[now]', :immediately
end

windows_package 'Seq' do
  action :install
  source node['seq']['source']
  checksum node['seq']['checksum']
  not_if { File.exist?('C:\Program Files\Seq\seq.exe') }
end

execute 'Install Service' do
  command '"C:\Program Files\Seq\seq.exe" install'
  action :run
  not_if { ::Win32::Service.exists?('Seq') }
end

execute 'Start Service' do
  command '"C:\Program Files\Seq\seq.exe" start'
  action :run
  not_if { ::Win32::Service.status('Seq').current_state == 'running' }
end
