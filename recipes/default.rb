require 'win32/service'

package 'Seq' do
  action :install
  source node['seq']['source']
  not_if do File.exists?('C:\Program Files\Seq\seq.exe') end
end

execute 'Install Service' do
  command '"C:\Program Files\Seq\seq.exe" install'
  action :run
  not_if do ::Win32::Service.exists?('Seq') end
end

execute 'Start Service' do
  command '"C:\Program Files\Seq\seq.exe" start'
  action :run
  not_if do ::Win32::Service.status('Seq').current_state == "running" end
end
