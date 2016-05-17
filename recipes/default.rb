if RUBY_PLATFORM =~ /mswin|mingw32|windows/
  require "win32/service"
end

package 'Seq' do
  action :install
  source node['seq']['source']
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
