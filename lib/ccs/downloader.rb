# frozen_string_literal: true

module Ccs
  # Downloads and decrypts the document at given URI with given access token.
  # Decryption occurs using given passphrase.
  class Downloader
    # Constructs a Downloader instance from a given URI, access token and passphrase.
    #
    # @example
    #    uri = 'ccs://path/to/file.yml'
    #    access_token = 'f30b5450421362c9ca0b'
    #    passphrase = 'my document passphrase'
    #
    #    Ccs::Downloader.new(uri, access_token, passphrase)
    #
    # @param uri [String] Document URI. Accepts `ccs://` as shorthand for Occson location.
    # @param access_token [String] Occson access token.
    # @param passphrase [String] Document passphrase, used in encryption and decryption.
    def initialize(uri, access_token, passphrase)
      @uri = uri
      @access_token = access_token
      @passphrase = passphrase
    end

    # Performs the download and decryption of document.
    #
    # @return [String|nil] Decrypted body of the document or `nil` in case the
    #   server did not respond with a `200` HTTP code.
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
