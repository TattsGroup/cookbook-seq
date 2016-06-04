# Seq Server Chef Cookbook

[![Build Status](https://travis-ci.org/TattsGroup/cookbook-seq.png?branch=master)](https://travis-ci.org/TattsGroup/cookbook-seq)

This is an Chef cookbook for [Seq](http://getseq.net), a structured logging server.

# Requirements

## Supported Operating Systems

* Windows 7
* Windows Server 2008
* Windows Server 2008R2
* Windows 8
* Windows Server 2012
* Windows Server 2012R2

## Cookbooks

* ms_dotnet

## Attributes

* `node['seq']['source']` - Source URL to obtain Seq installation msi
* `node['seq']['checksum']` - Source URL to obtain Seq installation

# Usage

## default

Installs and configures a default Seq instance.  Will ensure .NET Framework 4.5.2 is installed.

## Examples

```ruby
include_recipe 'seq::default'
```

## Maintenance

### Releasing Changes to Supermarket
```
rake rubocop
rake foodcritic
rake rspec

knife cookbook site share seq --user <username> --key <username>.pem
```

## Copyright & License

Copyright (c) 2016 Tatts Group Limited

Released under the [MIT license](http://www.opensource.org/licenses/mit-license.php).
