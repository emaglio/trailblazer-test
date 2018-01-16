module Trailblazer::Test
  module TestEnv
    def assert_equal(exp, act, msg = nil)
      ancestors = self.class.ancestors.join(',')
      case
      when ancestors.include?('Minitest')
        super
      when ancestors.include?('RSpec')
        expect(exp).to eq(act), msg
      else
        raise UnknownTestEnv, "Test ENV not implemented (minitest or rspec)"
      end
    end
  end

  class UnknownTestEnv < RuntimeError
  end
end
