require 'spec_helper'

describe Squid do

  describe '#build_id_variable' do
    it 'defaults to "SQUID_BUILD_ID"' do
      expect(Squid.build_id_variable).to eq('SQUID_BUILD_ID')
    end

    it 'can be changed to any non-falsy value' do
      Squid.build_id_variable = 'MY_BUILD_ID'
      expect(Squid.build_id_variable).to eq('MY_BUILD_ID')

      Squid.build_id_variable = nil  # reset global state
    end
  end

end
