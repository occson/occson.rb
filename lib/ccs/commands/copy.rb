# frozen_string_literal: true

module Ccs
  module Commands
    class Copy
      def initialize(source, destination, access_token, passphrase, force: false)
        @source = source
        @destination = destination
        @access_token = access_token
        @passphrase = passphrase
        @force = force
      end

      def call
        download? ? download : upload
      end

      private

      def download?
        @source.match?(%r{\A(ccs|https?):\/\/})
      end

      def download
        content = Document.new(@source, @access_token, @passphrase).download
        return unless content

        (@destination.eql?('-') ? STDOUT : File.new(@destination, 'w')).print content
      end

      def upload
        content = @source.eql?('-') ? STDIN.read : File.read(@source)
        Document.new(@destination, @access_token, @passphrase).upload(content, force: @force)
      end
    end
  end
end
