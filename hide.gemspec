# coding: utf-8

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "hide/version"

Gem::Specification.new do |s|
  s.name	= "hide"
  s.version	= Hide::VERSION
  s.summary	= "A simple encryption utility"
  s.description = "Hide is a basic utility to encrypt/decrypt
light-weight data files"
  s.authors	= ["Tahmid Shakil"]
  s.email	= ["at.shakil.92@gmail.com"]
  s.files	= `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test)/}) }
  s.bindir = "bin"
  s.executables = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.required_ruby_version = [">= 2.3.0"]
  s.rdoc_options = %w[-t Hide -m README.md -N --markup markdown]
  s.homepage	= "https://github.com/atshakil/hide"
  s.license	= "MIT"

  s.add_dependency "openssl", "~> 2.0"

  s.add_development_dependency "appraisal", "~> 2.2"
  s.add_development_dependency "bundler", "~> 1.15"
  s.add_development_dependency "minitest", "~> 5.0"
  s.add_development_dependency "rake", "~> 12.0"
  s.add_development_dependency "simplecov", "~> 0.13"

  if ENV["TRAVIS"]
    s.add_development_dependency "codeclimate-test-reporter", "~> 1.0.8"
  end
end
