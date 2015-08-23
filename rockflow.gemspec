# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rockflow/version'

Gem::Specification.new do |spec|
  spec.name = "rockflow"
  spec.version = Rockflow::VERSION
  spec.authors = ["Erwin Schens"]
  spec.email = ["erwinschens@uni-koblenz.de"]

  spec.summary = %q{Create workflows the easy way}
  spec.description = %q{Rockflow allows you to define easy workflows that rock.}
  spec.homepage = "http://qurasoft.de"
  spec.license = "MIT"

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'parallel', '~> 1.6.1', '>= 1.6.1'

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.3"
end
