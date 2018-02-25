# frozen_string_literal: true

module Ccs
  class Application
    def initialize(source, destination, access_token, secret_token)
      @source = source
      @destination = destination
      @access_token = access_token
      @secret_token = secret_token
    end

    def run
      download? ? download : upload
    end

    private

    def download?
      @source.match?(%r{\A(ccs|https?):\/\/})
    end

    def download
      content = ConfigurationFile.new(@source, @access_token, @secret_token).download
      return unless content

      (@destination.eql?('-') ? STDOUT : File.new(@destination, 'w')).print content
    end

    def upload
      content = @source.eql?('-') ? STDIN.read : File.read(@source)
      ConfigurationFile.new(@destination, @access_token, @secret_token).upload(content)
    end
  end
end
