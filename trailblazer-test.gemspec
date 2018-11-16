lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "trailblazer/test/version"

Gem::Specification.new do |spec|
  spec.name          = "trailblazer-test"
  spec.version       = Trailblazer::Test::VERSION
  spec.authors       = ["Nick Sutterer"]
  spec.email         = ["apotonick@gmail.com"]

  spec.summary       = %q{Assertions, matchers, and helpers to test Trailblazer code.}
  spec.description   = %q{Assertions, matchers, and helpers to test Trailblazer code.}
  spec.homepage      = "http://trailblazer.to"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "deep_merge"

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rubocop"
end
