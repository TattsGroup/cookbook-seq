require 'spec_helper'

describe 'seq::default' do

  
  describe port(5341) do
    it { should be_listening }
  end
  
end
