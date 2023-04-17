# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'occson/version'

Gem::Specification.new do |spec|
  spec.name = 'occson'
  spec.version = Occson::VERSION
  spec.authors = ['tkowalewski', 'paweljw']
  spec.email = ['me@tkowalewski.pl', 'p@steamshard.net']
  spec.summary = 'Store, manage and deploy configuration securely with Occson.'
  spec.description = ''
  spec.homepage = 'https://github.com/occson/occson.rb'
  spec.license = 'MIT'
  spec.bindir = 'exe'
  spec.executables << 'occson'
  spec.files = Dir['CHANGELOG.md', 'CODE_OF_CONDUCT.md', 'LICENSE.txt', 'README.md', 'lib/**/*']
  spec.require_paths = ['lib']
  spec.add_development_dependency 'inch', '~> 0.8.0'
  spec.add_development_dependency 'pry', '~> 0.14.1'
  spec.add_development_dependency 'rake', '~> 13.0.1'
  spec.add_development_dependency 'reek', '~> 6.1.3'
  spec.add_development_dependency 'rspec', '~> 3.12.0'
  spec.add_development_dependency 'rubocop', '~> 1.50.2'
  spec.add_development_dependency 'simplecov', '~> 0.22.0'
  spec.add_development_dependency 'webmock', '~> 3.18.1'
  spec.add_development_dependency 'yard', '>= 0.9.11'
  spec.add_development_dependency 'rexml', '~> 3.2.5'
end
