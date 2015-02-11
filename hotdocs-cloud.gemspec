# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hotdocs/cloud/version'

Gem::Specification.new do |spec|
  spec.name          = "hotdocs-cloud"
  spec.version       = Hotdocs::Cloud::VERSION
  spec.authors       = ["Pierre G.\n"]
  spec.email         = ["pierr@pifleo.fr"]
  spec.description   = %q{A wrapper for HotDocs Cloud Services API}
  spec.summary       = %q{A wrapper for HotDocs Cloud Services API}
  spec.homepage      = "http://help.hotdocs.com/cloudservices/"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_runtime_dependency "ruby-hmac", "~> 0.4.0"
  spec.add_runtime_dependency "rest-client", "~> 1.6.7" # https://github.com/rest-client/rest-client
  spec.add_runtime_dependency "nokogiri"
end
