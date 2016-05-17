require 'spec_helper'
require 'win32_helper'

describe 'seq::default' do
  context 'on windows 2012r2' do
    let(:chef_run) do
      ChefSpec::ServerRunner.new(platform: 'windows', version: '2012R2', log_level: :error) do
        # allow_any_instance_of(::Win32::Service).to receive(:exists?).and_return(false)
      end.converge(described_recipe)
    end

    context 'installing .net 4.5.2' do
      it 'installs .net 4.5.2' do
        expect(chef_run).to install_ms_dotnet_framework('4.5.2')
      end
    end

    context 'when installing Seq' do
      it 'installs Seq when it does not exist' do
        allow(File).to receive(:exist?)
          .and_call_original
        allow(File).to receive(:exist?)
          .with('C:\Program Files\Seq\seq.exe')
          .and_return(true)

        expect(chef_run).to_not install_package('Seq')
      end

      it 'does not install Seq when it already exists' do
        allow(File).to receive(:exist?)
          .and_call_original
        allow(File).to receive(:exist?)
          .with('C:\Program Files\Seq\seq.exe')
          .and_return(true)

        expect(chef_run).to_not install_package('Seq')
      end
    end

    context 'when configuring service' do
      it 'installs Seq windows service when it does not exist' do
        allow(Win32::Service).to receive(:exists?).and_return(false)
        expect(chef_run).to run_execute('"C:\Program Files\Seq\seq.exe" install')
      end

      it 'does not install Seq windows service when it already exists' do
        allow(Win32::Service).to receive(:exists?).and_return(true)
        expect(chef_run).to_not run_execute('"C:\Program Files\Seq\seq.exe" install')
      end
    end

    context 'when starting service' do
      it 'starts Seq windows service when it is not started' do
        allow(Win32::Service).to receive(:status).and_return(Win32::StatusStruct.new('stopped'))
        expect(chef_run).to run_execute('"C:\Program Files\Seq\seq.exe" start')
      end

      it 'does not start Seq windows service when it is already started' do
        allow(Win32::Service).to receive(:status).and_return(Win32::StatusStruct.new('running'))
        expect(chef_run).to_not run_execute('"C:\Program Files\Seq\seq.exe" start')
      end
    end
  end
end
