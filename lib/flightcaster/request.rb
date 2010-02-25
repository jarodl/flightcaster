module FlightCaster
  class Request

    API_ROOT = "http://api.flightcaster.com"

    def self.set_api_key(api_key)
      @api_key = api_key
    end

    def self.get(path, params={})
      uri = full_uri(path)
      response = HTTParty.get(uri, params)
      make_friendly(response)
    end

    def self.full_uri(path)
      "#{API_ROOT}#{path}?api_key=#{@api_key}"
    end

    def self.make_friendly(response)
      raise_errors(response)
      data = parse(response)
      Hashie::Mash.new(data)
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

  end
end
