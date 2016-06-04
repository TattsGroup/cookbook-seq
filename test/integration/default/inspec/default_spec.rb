control 'Seq Server' do
  describe file('C:\Program Files\Seq\Seq.exe') do
    it { should exist }
  end

  describe port(5341) do
    it { should be_listening }
    its('protocols') { should eq ['tcp'] }
  end

  describe service('Seq') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end
end
