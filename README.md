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

Required
* `node['seq']['source']` - Source URL to obtain Seq installation MSI file
* `node['seq']['checksum']` - SHA256 Checksum of Seq installation MSI file

Optional
* `node['seq']['license']` - Base64 Encoded Seq License

# Usage

## default

Installs and configures a default Seq instance.  Will ensure .NET Framework 4.5.2 is installed.

## Examples

```ruby
include_recipe 'seq::default'
include_recipe 'seq::license'
```

## Node JSON

> Note: Do not use the sample license below as it is designed for testing only, attempting to use it in a production setting will most likely break your Seq instance.

node.json:

```json
{
  "seq": {
    "source": "https://getseq.blob.core.windows.net/releases/Seq-3.1.17.msi",
    "checksum": "68822a804f4eddc709d49231c4e0b393db8fe7c5919c2277ee436a6d87a5fd9f",
    "license": "U2VyaWFsOiBTREVTLTAxLU0zMjg3NzAwCklzc3VlZC1CeTogRGF0YWx1c3QgUHR5IEx0ZApMaWNlbnNlZC1UbzogVGF0dHMgR3JvdXAsIFRlc3QgT25seQpWYWxpZC1Gcm9tOiBTYXQsIDA0IEp1biAyMDE2IDAzOjAwOjUxIEdNVApVcGdyYWRlLVVudGlsOiBTdW4sIDA0IEp1biAyMDE3IDAzOjAwOjUxIEdNVApMaWNlbnNlZC1Vc2VyczogMApOb3RlczogRm9yIGF1dG9tYXRlZCBjb29rYm9vay1zZXEgdGVzdGluZyBvbmx5ClNpZ25hdHVyZTogNEJzMkcrazU4b0hxL1hlTFlvZTUzZHpjYTFTdUZBRUM1R0N1MmxZd0F6Ym5rdGZEQzcwcllyd2IyK1RqTHp2cml4RDYKICBodDFjYlUvNmZlWlRIYURpeHlTTlRRUVJsbUM1RTJvRFMzdlBjdXBIbXFhWW5OTDR1ZnJVeE96Zk04cnZPK3pKSjRpOTRkVlZHMEU2YgogIC9aeU5FcGFqRldWVFk1K3d3Z1VPOVA3M2UvbTNjdm52K0pWSGs3bDNzMk5yVlJzUzNSREhXTWNDSlk5ZzRscjB1RWFoQXQzdjl3NzdTCiAgWkFCMWREdnBDTWVmVXViWlIwUkNaRXMxNGVDVWZiaWJWOHZFWkxDOVRrSHhLNWdOYUpCYWN4Yzd3UE5MYVdzVG42ZkNFS2xTeUhITkkKICBKcG9aRGxscDNkY2tJT1MvZmRUOTIxRXFkUjY0VkQyTFloQ2xseDgrcFV3PT0K"
  },
  "run_list": [
    "recipe[seq::default]",
    "recipe[seq::license]"
  ]
}
```

## Development and Testing

### Releasing Changes to Supermarket
```bash
# Test Code Quality
rake rubocop
rake foodcritic

# Run Unit Tests
rake rspec

# Run Integration Tests
kitchen converge
kitchen converge # required due to reboot for .NET installation
kitchen verify
kitchen destroy

# Bump Version
thor version:bump minor # (or major)

# Push changes to Supermarket
knife cookbook site share seq --user <username> --key <username>.pem
```

## Copyright & License

Copyright (c) 2016 Tatts Group Limited

Released under the [MIT license](http://www.opensource.org/licenses/mit-license.php).
