# frozen_string_literal: true

module Ccs
  # Encrypts and uploads the document to Occson.
  class Uploader
    # Constructs an Uploader instance from a given URI, content, access token and passphrase.
    #
    # @example
    #    uri = 'ccs://path/to/file.yml'
    #    content = 'my very secret message'
    #    access_token = 'f30b5450421362c9ca0b'
    #    passphrase = 'my document passphrase'
    #
    #    Ccs::Uploader.new(uri, access_token, passphrase)
    #
    # @param uri [String] Document URI. Accepts `ccs://` as shorthand for Occson location.
    # @param content [String] Plaintext for encryption and upload.
    # @param access_token [String] Occson access token.
    # @param passphrase [String] Document passphrase, used in encryption and decryption.
    # @param force [Boolean] Whether to overwrite target document in Occson, if any. Default `false`.
    def initialize(uri, content, access_token, passphrase, force: false)
      @uri = uri
      @content = content
      @access_token = access_token
      @passphrase = passphrase
      @force = force.to_s
    end

    # Performs the actual upload to server.
    #
    # @return [Boolean] `true` for a successful upload, `false` otherwise
    def call
      request.body = { encrypted_content: encrypted_content, force: @force }.to_json
      %w[200 201].include?(http.request(request).code)
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
      @encrypted_content ||= Encrypter.new(@passphrase, @content, salt).call
    end

    def salt
      @access_token[0...8]
    end
  end
end
