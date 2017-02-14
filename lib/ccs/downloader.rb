module Ccs
  class Downloader
    def initialize(token, configuration_file)
      @token = token
      @configuration_file = configuration_file
    end

    def download
      response = http.request(request)

      return unless response.class == Net::HTTPOK

      JSON.parse(response.body)
    end

    private

    def uri
      @uri ||= URI format('https://pipello.io/api/v1/ccs/%s/%s', @configuration_file.version, @configuration_file.path)
    end

    def http
      Net::HTTP.new(uri.host, uri.port).tap do |http|
        http.use_ssl = uri.scheme == 'https'
      end
    end

    def request
      Net::HTTP::Get.new(uri.path, headers)
    end

    def headers
      { 'Authorization' => format('Token token=%s', @token) }
    end
  end
end
