# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'scratch/version'

Gem::Specification.new do |spec|
  spec.name          = "scratch"
  spec.version       = Scratch::VERSION
  spec.authors       = ["Mike Williamson"]
  spec.email         = ["mike@korora.ca"]
  spec.summary       = "A tiny DSL for web scraping."
  spec.description   = "A cute little DSL for picking information off of web pages."
  spec.homepage      = "https://github.com/sleepycat/scratch"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rspec", "~> 2.14"
  spec.add_development_dependency "webmock", "~> 1.7"
  spec.add_development_dependency "pry", "~> 0.9"
  spec.add_dependency "nokogiri", "~> 1.6"
end
