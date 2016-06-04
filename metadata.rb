name              'seq'
maintainer        'Shaw Innes'
maintainer_email  'shaw.innes@tattsgroup.com'
license           'MIT'
description       'Installs/Configures Seq'
source_url        'https://github.com/TattsGroup/cookbook-seq'
issues_url        'https://github.com/TattsGroup/cookbook-seq/issues'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
chef_version '>= 12'
begin
  version IO.read(File.join(File.dirname(__FILE__), 'VERSION'))
rescue
  version '0.1.0'
end

recipe 'seq::default', 'Installs and configures a Seq server instance'

supports 'windows'

depends 'ms_dotnet'
