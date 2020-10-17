# frozen_string_literal: true

require 'rack'
require 'fileutils'
require 'json'

class Document
  def initialize(path)
    @path = File.join('/fake_occson', path)
  end

  def exist?
    File.exist? @path
  end

  def read
    File.read @path
  end

  def write(content)
    FileUtils.mkdir_p File.dirname(@path)

    File.open(@path, 'w') { |f| f.write content }
  end
end

class Application
  def call(env)
    return unauthorized unless http_token_authorized?(env)

    request = Rack::Request.new(env)

    document = Document.new(request.path_info)

    if request.post?
      return conflict if document.exist?
      json = JSON.parse(request.body.read)

      document.write json['encrypted_content']

      [201, { 'Content-Type' => 'application/json' }, [{ message: 'Created', status: 201 }.to_json]]
    elsif request.get?
      return not_found unless document.exist?

      content = document.read

      [200, { 'Content-Type' => 'application/json' }, [{ message: 'OK', status: 200, encrypted_content: content }.to_json]]
    else
      [405, { 'Content-Type' => 'application/json' }, [{ message: 'Method Not Allowed', status: 405 }.to_json]]
    end
  end

  def http_token_authorized?(env)
    return false unless env['HTTP_AUTHORIZATION']

    match_data = env['HTTP_AUTHORIZATION'].match(/\AToken token=(?<token>.*)/)
    match_data['token'].eql? ENV['CCS_ACCESS_TOKEN']
  end

  def unauthorized
    [401, { 'Content-Type' => 'application/json' }, [{ message: 'Unauthorized', status: 401 }.to_json]]
  end

  def not_found
    [404, { 'Content-Type' => 'application/json' }, [{ message: 'Not Found', status: 404 }.to_json]]
  end

  def conflict
    [409, { 'Content-Type' => 'application/json' }, [{ message: 'Conflict', status: 409 }.to_json]]
  end
end

run Application.new
