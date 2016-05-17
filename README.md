# Seq Server Chef Cookbook

This is an Chef cookbook for [Seq](http://getseq.net) a structured logging server.

## Recipes

* `seq::default` - Installs and configures a default Seq instance

## Attributes

* `node['seq']['source']` - Source URL to obtain Seq installation msi
* `node['seq']['checksum']` - Source URL to obtain Seq installation

## Supported Operating Systems

Windows Server 2012
Windows Server 2012r2

## Cookbooks

* ms_dotnet

## Examples

```ruby
include_recipe 'seq::default'
```

## Copyright & License

Copyright (c) 2016 Tatts Group Limited

Released under the [MIT license](http://www.opensource.org/licenses/mit-license.php).
