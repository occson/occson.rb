# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ccs/version'

Gem::Specification.new do |spec|
  spec.name = 'ccs'
  spec.version = Ccs::VERSION
  spec.authors = ['tkowalewski']
  spec.email = ['me@tkowalewski.pl']
  spec.summary = 'Configuration Control System (CCS)'
  spec.description = ''
  spec.homepage = 'https://github.com/tkowalewski/ccs'
  spec.license = 'MIT'
  spec.bindir = 'exe'
  spec.executables << 'ccs'
  spec.files = Dir['CHANGELOG.md', 'CODE_OF_CONDUCT.md', 'LICENSE.txt', 'README.md', 'lib/**/*']
  spec.require_paths = ['lib']
  spec.add_development_dependency 'inch', '~> 0.8.0'
  spec.add_development_dependency 'pry', '~> 0.11.3'
  spec.add_development_dependency 'rake', '~> 12.3.0'
  spec.add_development_dependency 'reek', '~> 4.7.3'
  spec.add_development_dependency 'rspec', '~> 3.7.0'
  spec.add_development_dependency 'rubocop', '~> 0.52.1'
  spec.add_development_dependency 'simplecov', '~> 0.15.1'
  spec.add_development_dependency 'webmock', '~> 3.3.0'
  spec.add_development_dependency 'yard', '>= 0.9.11'
end
