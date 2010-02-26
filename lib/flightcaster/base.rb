module FlightCaster
  class Base
    attr_reader :api_key

    def initialize(api_key)
      @api_key = api_key
      FlightCaster::Request.set_api_key(@api_key)
    end

    def airlines(params={})
      perform_get('/airlines.xml', params)
    end

    def airline(id, params={})
      perform_get("/airlines/#{id}.xml", params)
    end

    def airports(params={})
      perform_get('/airports.xml', params)
    end

    def airport(id, params={})
      perform_get("/airports/#{id}.xml", params)
    end

    def flights(params={})
      perform_get('/flights.xml', params)
    end

    def flight(id, params={})
      perform_get("/flights/#{id}.xml", params)
    end

    private

    def perform_get(path, params={})
      FlightCaster::Request.get(path, params)
    end

  end
end