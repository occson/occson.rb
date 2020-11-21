# frozen_string_literal: true

module Ccs
  # An abstraction for the Document concept. Simplifies building URLs,
  # uploading and downloading contents. Abstracts away workspaces due to
  # the use of access tokens in constructions.
  class Document
    # Constructs a Document instance from a given URI, access token and passphrase.
    #
    # @example
    #    uri = 'ccs://path/to/file.yml'
    #    access_token = 'f30b5450421362c9ca0b'
    #    passphrase = 'my document passphrase'
    #
    #    Ccs::Document.new(uri, access_token, passphrase)
    #
    # @param uri [String] Document URI. Accepts `ccs://` as shorthand for Occson location.
    # @param access_token [String] Occson access token.
    # @param passphrase [String] Document passphrase, used in encryption and decryption.
    def initialize(uri, access_token, passphrase)
      @uri = build_uri(uri)
      @access_token = access_token
      @passphrase = passphrase
    end

    # Uploads the given plaintext `content` to target URI.
    #
    # @example
    #     document.upload('My example plaintext.')
    #
    # @param content [String] Plaintext to be encrypted and uploaded.
    # @param force [Boolean] Whether to overwrite target document in Occson, if any. Default `false`.
    def upload(content, force: false)
      Uploader.new(@uri, content, @access_token, @passphrase, force: force).call
    end

    # Downloads the encrypted document at `@uri` and returns the plaintext
    # contents (given that `@passphrase` matches).
    #
    # @example
    #    plaintext = document.download
    #
    # @return [String] Decrypted document contents
    def download
      Downloader.new(@uri, @access_token, @passphrase).call
    end

    private

    def build_uri(uri)
      URI uri.sub('ccs://', 'https://api.occson.com/')
    end
  end
end
