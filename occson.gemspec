# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'occson/version'

Gem::Specification.new do |spec|
  spec.name = 'occson'
  spec.required_ruby_version = '>= 2.7.0'
  spec.metadata = { 'rubygems_mfa_required' => 'true' }
  spec.version = Occson::VERSION
  spec.authors = %w[tkowalewski paweljw]
  spec.email = ['me@tkowalewski.pl', 'p@steamshard.net']
  spec.summary = 'Store, manage and deploy configuration securely with Occson.'
  spec.description = ''
  spec.homepage = 'https://github.com/occson/occson.rb'
  spec.license = 'MIT'
  spec.bindir = 'exe'
  spec.executables << 'occson'
  spec.files = Dir['CHANGELOG.md', 'CODE_OF_CONDUCT.md', 'LICENSE.txt', 'README.md', 'lib/**/*']
  spec.require_paths = ['lib']
end
