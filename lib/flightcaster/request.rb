module FlightCaster
  class Request
    API_ROOT = "http://api.flightcaster.com"
    API_VERSION = "0.1.1"

    def self.set_api_key(api_key)
      @api_key = api_key
    end

    def self.get(path, params={})
      uri = full_uri(path, params)
      response = HTTParty.get(uri)
      make_friendly(response)
    end

    def self.full_uri(path, params={})
      options = expand(params)
      "#{API_ROOT}#{path}?api_key=#{@api_key}&api_version=#{API_VERSION}#{options}"
    end

    def self.make_friendly(response)
      begin
        raise_errors(response)
        data = parse(response)
        h = Hashie::Mash.new(data)
        h = h[h.keys[0]]
        FlightCaster::Rash.new(h)
      rescue
      end
    end

    def self.raise_errors(response)
      case response.code.to_i
        when 404
          raise NotFound, "(#{response.code}): #{response.message}"
        when 422
          raise OldAPI, "The API version you are using is no longer supported. (#{response.code}): #{response.message}"
      end
    end

    def self.parse(response)
      Crack::XML.parse(response.body)
    end

    def self.expand(params)
      final = ''
      params.each do |k, v|
        final << "&#{k}=#{v}"
      end
      final
    end
  end
end
