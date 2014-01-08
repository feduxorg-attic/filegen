# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'filegen/version'

Gem::Specification.new do |spec|
  spec.name          = "filegen"
  spec.version       = Filegen::VERSION
  spec.authors       = ["Dennis Günnewig"]
  spec.email         = ["dg1@vrnetze.de"]
  spec.description   = %q{Evaluate erb templates}
  spec.summary       = %q{This helper takes an erb template and provides access to environment variables within that template}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
