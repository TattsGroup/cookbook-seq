name              'seq'
maintainer        'Shaw Innes'
maintainer_email  'shaw.innes@tattsgroup.com'
license           'MIT'
description       'Installs/Configures Seq'
source_url        'https://github.com/TattsGroup/cookbook-seq'
issues_url        'https://github.com/TattsGroup/cookbook-seq/issues'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
begin
  IO.read(File.join(File.dirname(__FILE__), 'VERSION'))
rescue
  '0.1.0'
end

depends 'ms_dotnet'
