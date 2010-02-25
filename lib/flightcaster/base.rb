module FlightCaster
  class Base
    attr_reader :api_key

    def initialize(api_key)
      @api_key = api_key
      FlightCaster::Request.set_api_key(@api_key)
    end

    def airlines(params={})
      perform_get('/airlines.xml', params).airlines
    end

    def airports(params={})
      perform_get('/airports.xml', params).airports
    end

    def flights(params={})
      perform_get('/flights.xml', params).flights
    end

    private

    def perform_get(path, params={})
      FlightCaster::Request.get(path, params)
    end

  end
end
