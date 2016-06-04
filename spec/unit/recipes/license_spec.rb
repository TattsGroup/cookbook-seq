require 'spec_helper'
require 'json'
require 'base64'

describe 'seq::license' do
  context 'on windows 2012r2' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new(platform: 'windows', version: '2012R2')
    end

    before do
      allow_any_instance_of(Chef::HTTP).to receive(:get).and_call_original
      allow_any_instance_of(Chef::HTTP).to receive(:get).with('/api/licenses/license-server').and_return({ Id: 'license-server', LicenseText: 'license' }.to_json)
    end

    context 'without a license file' do
      it 'does not put a license file' do
        chef_run.node.set['seq']['license'] = nil
        chef_run.converge(described_recipe)

        expect(chef_run).to_not put_http_request('load seq license').with(url: 'http://localhost:5341/api/licenses/license-server')
      end
    end

    context 'with a license file' do
      let(:license_text) do
        'U2VyaWFsOiBTREVTLTAxLU0zMjg3NzAwCklzc3VlZC1CeTogRGF0YWx1c3QgUHR5IEx0ZApMaWNlbnNlZC1UbzogVGF0dHMgR3JvdXAsIFRlc3QgT25seQpWYWxpZC1Gcm9tOiBTYXQsIDA0IEp1biAyMDE2IDAzOjAwOjUxIEdNVApVcGdyYWRlLVVudGlsOiBTdW4sIDA0IEp1biAyMDE3IDAzOjAwOjUxIEdNVApMaWNlbnNlZC1Vc2VyczogMApOb3RlczogRm9yIGF1dG9tYXRlZCBjb29rYm9vay1zZXEgdGVzdGluZyBvbmx5ClNpZ25hdHVyZTogNEJzMkcrazU4b0hxL1hlTFlvZTUzZHpjYTFTdUZBRUM1R0N1MmxZd0F6Ym5rdGZEQzcwcllyd2IyK1RqTHp2cml4RDYKICBodDFjYlUvNmZlWlRIYURpeHlTTlRRUVJsbUM1RTJvRFMzdlBjdXBIbXFhWW5OTDR1ZnJVeE96Zk04cnZPK3pKSjRpOTRkVlZHMEU2YgogIC9aeU5FcGFqRldWVFk1K3d3Z1VPOVA3M2UvbTNjdm52K0pWSGs3bDNzMk5yVlJzUzNSREhXTWNDSlk5ZzRscjB1RWFoQXQzdjl3NzdTCiAgWkFCMWREdnBDTWVmVXViWlIwUkNaRXMxNGVDVWZiaWJWOHZFWkxDOVRrSHhLNWdOYUpCYWN4Yzd3UE5MYVdzVG42ZkNFS2xTeUhITkkKICBKcG9aRGxscDNkY2tJT1MvZmRUOTIxRXFkUjY0VkQyTFloQ2xseDgrcFV3PT0K'
      end

      let(:payload) do
        license = ::Base64.decode64(license_text)
        { Id: 'license-server', LicenseText: license }
      end

      before do
        chef_run.node.set['seq']['license'] = license_text
      end

      context 'and Seq Server is not installed' do
        it 'does not put a license file' do
          allow(Win32::Service).to receive(:exists?).and_return(false)

          chef_run.converge(described_recipe)

          expect(chef_run).to_not put_http_request('load seq license').with(url: 'http://localhost:5341/api/licenses/license-server')
        end
      end

      context 'and Seq Server is NOT running' do
        it 'does not put a license file' do
          allow(Win32::Service).to receive(:exists?).and_return(true)
          allow(Win32::Service).to receive(:status).and_return(Win32::StatusStruct.new('stopped'))

          chef_run.converge(described_recipe)

          expect(chef_run).to_not put_http_request('load seq license').with(url: 'http://localhost:5341/api/licenses/license-server')
        end
      end

      context 'and Seq Server is running' do
        it 'puts a license file' do
          allow(Win32::Service).to receive(:exists?).and_return(true)
          allow(Win32::Service).to receive(:status).and_return(Win32::StatusStruct.new('running'))

          chef_run.converge(described_recipe)

          expect(chef_run).to put_http_request('load seq license')
            .with(url: 'http://localhost:5341/api/licenses/license-server',
                  message: JSON.generate(payload))
        end
      end
    end
  end
end
