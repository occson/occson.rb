# frozen_string_literal: true

module Ccs
  class Document
    def initialize(uri, access_token, passphrase)
      @uri = build_uri(uri)
      @access_token = access_token
      @passphrase = passphrase
    end

    def upload(content, force: false)
      Uploader.new(@uri, content, @access_token, @passphrase, force: force).call
    end

    def download
      Downloader.new(@uri, @access_token, @passphrase).call
    end

    private

    def build_uri(uri)
      URI uri.sub('ccs://', 'https://api.occson.com/')
    end
  end
end
