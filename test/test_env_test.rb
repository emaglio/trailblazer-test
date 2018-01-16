require "test_helper"

class TestEnvTest < Minitest::Spec
  describe 'minitest' do
    class MinitestTest < Minitest::Spec
      include Trailblazer::Test::TestEnv

      it { assert_equal "yeah", "yeah" }
    end
  end
end
