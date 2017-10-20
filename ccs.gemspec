lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ccs/version'

Gem::Specification.new do |spec|
  spec.name          = 'ccs'
  spec.version       = Ccs::VERSION
  spec.authors       = ['tkowalewski']
  spec.email         = ['me@tkowalewski.pl']
  spec.summary       = ''
  spec.description   = ''
  spec.homepage      = 'https://github.com/tkowalewski/ccs'
  spec.license       = 'MIT'
  spec.executables   << 'ccs'
  spec.files         = Dir['CHANGELOG.md', 'CODE_OF_CONDUCT.md', 'LICENSE.txt', 'README.md', 'lib/**/*']
  spec.require_paths = ['lib']
  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.44.1'
end
