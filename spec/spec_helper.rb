# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'rspec'
require 'pry'
require 'webmock/rspec'

if %w[1 true].include?(ENV['COVERAGE'])
  require 'simplecov'
  SimpleCov.formatters = [
    SimpleCov::Formatter::HTMLFormatter
  ]

  SimpleCov.start do
    add_filter '/spec/'
  end
end
require 'occson'
