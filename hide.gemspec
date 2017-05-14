# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name	= 'hide'
  s.version	= "0.1.1"
  s.summary	= "A simple encryption utility"
  s.description = "Hide is a basic utility to encrypt/decrypt light-weight \
    data files"
  s.authors	= ["Tahmid Shakil"]
  s.email	= ["at.shakil.92@gmail.com"]
  s.files	= `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  s.bindir = "bin"
  s.executables = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.required_ruby_version = [">= 2.2.0"]
  s.rdoc_options = %w[-t Hide -m README.md -i lib/**/*.rb -N --markup markdown]
  s.homepage	= "https://github.com/at-shakil/hide"
  s.license	= 'MIT'

  s.add_dependency "openssl", "~> 2.0"

  s.add_development_dependency "bundler", "~> 1.15"
  s.add_development_dependency "rake", "~> 12.0"
  s.add_development_dependency "minitest", "~> 5.0"
end
