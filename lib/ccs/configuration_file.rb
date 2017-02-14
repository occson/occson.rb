module Ccs
  class ConfigurationFile
    def initialize(uri)
      @uri = uri
    end

    def version
      parts[0]
    end

    def path
      parts[1]
    end

    def to_path
      Pathname.new path
    end

    def to_s
      format 'ccs://%s/%s', version, path
    end

    private

    def parts
      @parts ||= @uri.sub('ccs://', '').split('/', 2)
    end
  end
end
