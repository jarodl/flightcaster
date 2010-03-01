module FlightCaster
  class Base
    attr_reader :api_key

    def initialize(api_key)
      @api_key = api_key
      FlightCaster::Request.set_api_key(@api_key)
    end

    # Params
    #   :per_page => The number of results per page. Defaults to 30.
    #   :page => The page of results displayed.
    def airlines(params={})
      perform_get('/airlines.xml', params)
    end

    # id
    #   The FlightCaster id
    #   The 2 character IATA id
    #   The 3 chracter ICAO id of the airline
    def airline(id)
      perform_get("/airlines/#{id}.xml")
    end

    # Params
    #   :per_page => The number of results per page. Defaults to 30.
    #   :page => The page of results displayed.
    def airports(params={})
      perform_get('/airports.xml', params)
    end

    # id
    #   The FlightCaster id
    #   The 3 character IATA id
    #   The 4 chracter ICAO id of the airport
    def airport(id)
      perform_get("/airports/#{id}.xml")
    end

    # id
    #   The FlightCaster id
    #   The 3 character IATA id
    #   The 4 chracter ICAO id of the airport
    # Get all arrivals at an airport.
    def airport_arrivals(id, params={})
      perform_get("/airports/#{id}/arrivals.xml", params)
    end

    # id
    #   The FlightCaster id
    #   The 3 character IATA id
    #   The 4 chracter ICAO id of the airport
    # Get all departures leaving an airport.
    def airport_departures(id, params={})
      perform_get("/airports/#{id}/departures.xml", params)
    end

    # id
    #   The id given to the flight by FlightCaster
    def flight(id)
      perform_get("/flights/#{id}.xml")
    end

    # params
    #   :per_page => The number of results per page. Defaults to 30.
    #   :page => The page of results displayed.
    def flights(params={})
      perform_get('/flights.xml', params)
    end

    # airline_id
    # flight_number
    # date
    #   A Ruby Time object
    #   or a date in the format 'yearmonthday' (ex: 20100226 = Feb. 26, 2010)
    # params
    #   :per_page => The number of results per page. Defaults to 30.
    #   :page => The page of results displayed.
    def flights_by_airline(airline_id, flight_number=nil, date=nil, params={})
      args = [airline_id, 'flights', flight_number, format(date)].compact.join('/')
      perform_get("/airlines/#{args}.xml", params)
    end

    def flight_route(origin, destination, date=nil, params={})
      args = [origin, 'departures', destination, format(date)].compact.join('/')
      perform_get("/airports/#{args}.xml", params)
    end

    def metars(params={})
      perform_get('/metars.xml', params)
    end

    def metar(id)
      perform_get("/metars/#{id}.xml")
    end

    def tafs(params={})
      perform_get('/tafs.xml', params)
    end

    def taf(id)
      perform_get("/tafs/#{id}.xml")
    end

    def ground_delays(params={})
      perform_get('/ground_delays.xml', params)
    end

    def ground_delay(id)
      perform_get("/ground_delays/#{id}.xml")
    end

    def ground_stops(params={})
      perform_get('/ground_stops.xml', params)
    end

    def ground_stop(id)
      perform_get("/ground_stops/#{id}.xml")
    end

    def delays(params={})
      perform_get('/delays.xml', params)
    end

    def delay(id)
      perform_get("/delays/#{id}.xml")
    end

    private

    def perform_get(path, params={})
      FlightCaster::Request.get(path, params)
    end

    def format(date)
      (date.is_a?(Time)) ? date.strftime("%Y%m%d") : date
    end

  end
end
