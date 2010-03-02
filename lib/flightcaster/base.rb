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

    # params
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
    #   or a date in the format 'yearmonthday' (ex: 20100226)
    # params
    #   :per_page => The number of results per page. Defaults to 30.
    #   :page => The page of results displayed.
    def flights_by_airline(airline_id, flight_number=nil, date=nil, params={})
      args = [airline_id, 'flights', flight_number, format(date)].compact.join('/')
      perform_get("/airlines/#{args}.xml", params)
    end

    # origin
    #   The FlightCaster id of the airport
    #   The 3 character airport IATA id
    #   The 4 character airport ICAO id
    # destination
    #   The FlightCaster id of the airport
    #   The 3 character airport IATA id
    #   The 4 character airport ICAO id
    # date
    #   A Ruby Time object
    #   A date in the format 'yearmonthday' (ex: 20100226)
    # Returns all flights going from one airport to another
    def flight_route(origin, destination, date=nil, params={})
      args = [origin, 'departures', destination, format(date)].compact.join('/')
      perform_get("/airports/#{args}.xml", params)
    end

    # params
    #   :per_page => The number of results per page. Defaults to 30.
    #   :page => The page of results displayed.
    # Returns all metars
    def metars(params={})
      perform_get('/metars.xml', params)
    end

    # id
    #   The FlightCaster id
    #   The 4 character metar ICAO id. If given the metar that is returned
    #   is the last one reported at that station.
    # Returns metar specified by the given id.
    def metar(id)
      perform_get("/metars/#{id}.xml")
    end

    # params
    #   :per_page => The number of results per page. Defaults to 30.
    #   :page => The page of results displayed.
    # Returns all tafs
    def tafs(params={})
      perform_get('/tafs.xml', params)
    end

    # id
    #   The FlightCaster id
    #   The 4 character taf ICAO id. If given the taf that is returned
    #   is the last one reported at that station.
    # Returns taf specified by the given id.
    def taf(id)
      perform_get("/tafs/#{id}.xml")
    end

    # params
    #   :per_page => The number of results per page. Defaults to 30.
    #   :page => The page of results displayed.
    # Returns a list of ground delays
    def ground_delays(params={})
      perform_get('/ground_delays.xml', params)
    end

    # id
    #   The FlightCaster id
    #   The 4 character delay ICAO id. If given, the delay that is returned
    #   is the last one reported at that station.
    # Returns a single ground delay.
    def ground_delay(id)
      perform_get("/ground_delays/#{id}.xml")
    end

    # Returns all ground stops, limited to 50 results.
    def ground_stops(params={})
      perform_get('/ground_stops.xml', params)
    end

    # id
    #   The FlightCaster id
    #   The 4 character stop ICAO id. If given, the stop that is returned
    #   is the last one reported at that station.
    # Returns a single ground stop.
    def ground_stop(id)
      perform_get("/ground_stops/#{id}.xml")
    end

    # params
    #   :per_page => The number of results per page. Defaults to 30.
    #   :page => The page of results displayed.
    # Returns all delays.
    def delays(params={})
      perform_get('/delays.xml', params)
    end

    # id
    #   The FlightCaster id
    #   The 4 character delay ICAO id. If given, the delay that is returned
    #   is the last one reported at that station.
    # Returns a single delay.
    def delay(id)
      perform_get("/delays/#{id}.xml")
    end

    private

    # :nodoc
    def perform_get(path, params={})
      FlightCaster::Request.get(path, params)
    end

    # :nodoc
    def format(date)
      (date.is_a?(Time)) ? date.strftime("%Y%m%d") : date
    end

  end
end
