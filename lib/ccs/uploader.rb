# frozen_string_literal: true

module Ccs
  class Uploader
    def initialize(uri, content, access_token, secret_token)
      @uri = uri
      @content = content
      @access_token = access_token
      @secret_token = secret_token
    end

    def call
      request.body = { encrypted_content: encrypted_content }.to_json
      http.request(request).code.eql? '201'
    end

    private

    def http
      @http ||= Net::HTTP.new(@uri.host, @uri.port).tap do |http|
        http.use_ssl = @uri.scheme.eql?('https')
      end
    end

    def request
      @request ||= Net::HTTP::Post.new(@uri.path, headers).tap do |request|
        request["User-Agent"] = format('ccs/%s', Ccs::VERSION)
      end
    end

    def headers
      {
        'Authorization' => format('Token token=%<access_token>s', access_token: @access_token),
        'Content-Type' => 'application/json'
      }
    end

    def encrypted_content
      @encrypted_content ||= Encrypter.new(@secret_token, @content, salt).call
    end

    def salt
      @access_token[0...8]
    end
  end
end
