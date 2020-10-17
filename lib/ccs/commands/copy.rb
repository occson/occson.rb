# frozen_string_literal: true

module Ccs
  module Commands
    class Copy
      def initialize(source, destination, access_token, secret_token)
        @source = source
        @destination = destination
        @access_token = access_token
        @secret_token = secret_token
      end

      def call
        download? ? download : upload
      end

      private

      def download?
        @source.match?(%r{\A(ccs|https?):\/\/})
      end

      def download
        content = Document.new(@source, @access_token, @secret_token).download
        return unless content

        (@destination.eql?('-') ? STDOUT : File.new(@destination, 'w')).print content
      end

      def upload
        content = @source.eql?('-') ? STDIN.read : File.read(@source)
        Document.new(@destination, @access_token, @secret_token).upload(content)
      end
    end
  end
end
