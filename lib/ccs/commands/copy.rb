# frozen_string_literal: true

module Ccs
  module Commands
    # The copy command, responsible for copying a target to a destination, performing encryption
    # and decryption as necessary.
    #
    # The target and destinations can be:
    # * STDIN/STDOUT: a `-` sign is interpreted as these standard streams
    # * The Occson server: strings beginning with `ccs://` or `http(s)://` are interpreted as such
    # * local files: everything not matching the previous descriptions is assumed to
    #   be a path on the local systm
    class Copy
      # Builds an instance of the Copy command.
      #
      # @param source [String] `-` for STDIN, an URI or a local file path
      # @param destination [String] `-` for STDOUT, an URI or a local file path
      # @param access_token [String] Occson access token
      # @param passphrase [String] Passphrase used for encryption of the document
      # @param force [Boolean] Whether to overwrite target document in Occson, if any. Default `false`.
      def initialize(source, destination, access_token, passphrase, force: false)
        @source = source
        @destination = destination
        @access_token = access_token
        @passphrase = passphrase
        @force = force
      end

      # Performs a transfer between locations - an upload if `@source` is local or STDIN,
      # a download if `@source` is an URI.
      #
      # No guarantees are made about the return values of this method.
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
