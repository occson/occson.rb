# frozen_string_literal: true

module Ccs
  class Document
    def initialize(uri, access_token, secret_token)
      @uri = build_uri(uri)
      @access_token = access_token
      @secret_token = secret_token
    end

    def upload(content)
      Uploader.new(@uri, content, @access_token, @secret_token).call
    end

    def download
      Downloader.new(@uri, @access_token, @secret_token).call
    end

    private

    def build_uri(uri)
      URI uri.sub('ccs://', 'https://api.occson.com/')
    end
  end
end
