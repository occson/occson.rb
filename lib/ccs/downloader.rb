# frozen_string_literal: true

module Ccs
  class Downloader
    def initialize(uri, access_token, passphrase)
      @uri = uri
      @access_token = access_token
      @passphrase = passphrase
    end

    def call
      response = http.request(request)
      body = response.body
      return unless response.code.eql? '200'
      json = JSON.parse body

      Decrypter.new(@passphrase, json['encrypted_content']).call
    end

    private

    def http
      @http ||= Net::HTTP.new(@uri.host, @uri.port).tap do |http|
        http.use_ssl = @uri.scheme.eql?('https')
      end
    end

    def request
      Net::HTTP::Get.new(@uri.path, headers).tap do |request|
        request["User-Agent"] = format('ccs/%s', Ccs::VERSION)
      end
    end

    def headers
      {
        'Authorization' => format('Token token=%<access_token>s', access_token: @access_token),
        'Content-Type' => 'application/json'
      }
    end
  end
end
