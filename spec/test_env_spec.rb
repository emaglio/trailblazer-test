require "spec_helper"

RSpec.describe 'RSpecTest' do
  include Trailblazer::Test::TestEnv

  describe do
    it { assert_equal "yeah", "yeah" }
  end
end
