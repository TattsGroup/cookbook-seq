require 'win32/service'

package 'seq' do
  action :install
  source node['seq']['source']
  not_if do File.exists?('C:\Program Files\Seq\seq.exe') end
end

execute 'install' do
  command '"C:\Program Files\Seq\seq.exe" install'
  action :run
  not_if do ::Win32::Service.exists?('Seq') end
end


execute 'start' do
  command '"C:\Program Files\Seq\seq.exe" start'
  action :run
  not_if do ::Win32::Service.status('Seq').current_state == "running" end
end


