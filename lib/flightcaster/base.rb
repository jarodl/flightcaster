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

    # Get all flights for a sepcific airline on a given date.
    def flights_by_airline_on(airline_id, flight_number, date, params={})
      t = convert_date(date)
      perform_get("/airlines/#{airline_id}/flights/#{flight_number}/#{t}.xml", params)
    end

    # Get all flights from one airport to another.
    def flight_path(from, to, params={})
      perform_get("/airports/#{from}/departures/#{to}.xml", params)
    end

    # Get all flights from one airport to another on a given date.
    def flight_path_on(from, to, date, params={})
      t = convert_date(date)
      perform_get("/airports/#{from}/departures/#{to}/#{t}.xml", params)
    end

    def flights(params={})
      perform_get('/flights.xml', params)
    end

    def flights_by_airline(id, params={})
      perform_get("/airlines/#{id}/flights.xml", params)
    end

    def flight_by_airline(airline_id, flight_number, params={})
      perform_get("/airlines/#{airline_id}/flights/#{flight_number}.xml", params)
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

    def convert_date(date)
      if date.class == Time
        date.strftime("%Y%m%d")
      else
        date
      end
    end

  end
end
