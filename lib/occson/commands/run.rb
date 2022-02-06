# frozen_string_literal: true

module Occson
  module Commands
    class Run
      def initialize(source, command, arguments, access_token, passphrase)
        @source = source
        @command = command
        @arguments = arguments
        @access_token = access_token
        @passphrase = passphrase
      end

      def call
        content = Document.new(@source, @access_token, @passphrase).download
        return unless content

        parsed_content = content.split("\n").map do |line|
          next if line.start_with?('#')

          line.split("=", 2) # @TODO handle wrapped values
        end.compact

        envs = Hash[parsed_content]

        system(envs, @command, *@arguments)
      end
    end
  end
end
