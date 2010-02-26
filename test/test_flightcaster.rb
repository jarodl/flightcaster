require 'helper'

class TestFlightCaster < Test::Unit::TestCase

  def setup
    @flightcaster = FlightCaster.new("foo")
  end

  context "Initialization" do
    should "require an API key" do
      lambda { FlightCaster.new }.should raise_error
    end

    should "be passed an API key" do
      FlightCaster.new("foo").api_key.should == "foo"
    end
  end

  context "Fetching airlines" do

    should "get all airlines" do
      stub_get('/airlines.xml', 'airlines.xml')
      airlines = @flightcaster.airlines
      airlines.current_page.should == '1'
      airlines.total_entries.should == '504'
      airlines.total_pages.should == '17'
    end

    should "get airlines on certain page" do
      stub_get('/airlines.xml', 'airlines_page.xml', '&page=3')
      airlines = @flightcaster.airlines(:page => 3)
      airlines.current_page.should == '3'
    end

    should "get airlines with 50 on each page" do
      stub_get('/airlines.xml', 'airlines_per_page.xml', '&per_page=50')
      airlines = @flightcaster.airlines(:per_page => 50)
      airlines.size.should == 50
    end

  end

  context "Fetching airline" do
    should "get one airline" do
      stub_get('/airlines/221.xml', 'airline.xml')
      airline = @flightcaster.airline(221)
      airline.callsign.should == 'UNITED'
      airline.name.should == 'United Airlines'
      airline.icao_id.should == 'UAL'
    end

    should "raise error when given invalid airline number" do
      stub_get('/airlines/-10.xml', 'notfound.xml', '', 404)
      @flightcaster.airline(-10).should raise_error
    end
  end

  context "Fetching airports" do
    should "get all airports" do
      stub_get('/airports.xml', 'airports.xml')
      airports = @flightcaster.airports
      airports.current_page.should == '1'
      airports.total_entries.should == '2026'
      airports.total_pages.should == '68'
      airports[0].city.should == 'New York'
    end
  end

  context "Fetching airport" do
    should "get one airport" do
      stub_get('/airports/1.xml', 'airport.xml')
      airport = @flightcaster.airport(1)
      airport.city.should == 'Waterford Township'
      airport.id.should == '1'
      airport.elevation.should == '299'
    end
  end

  context "Fetching flights" do
    should "get all flights" do
      stub_get('/flights.xml', 'flights.xml')
      flights = @flightcaster.flights
      flights[0].id.should == 2858102
      flights[0].status == 'Scheduled'
    end

    should "get flights by airline" do
      stub_get('/airlines/221/flights.xml', 'airline_flights.xml')
      flights = @flightcaster.flights_by_airline(221)
      flights.total_entries.should == '4898'
      flights.total_pages.should == '164'
    end

    should "get arrivals to airport" do
      stub_get('/airports/1/arrivals.xml', 'arrivals.xml')
      arrivals = @flightcaster.airport_arrivals(1)
      arrivals.total_entries.should == '15'
      arrivals.total_pages.should == '1'
    end

    should "get departures from airport" do
      stub_get('/airports/1/departures.xml', 'departures.xml')
      departures = @flightcaster.airport_departures(1)
      departures.total_entries.should == '16'
      departures.total_pages.should == '1'
    end

    should "get flights by airline and flight number" do
      stub_get('/airlines/VX/flights/28.xml', 'airline_flight.xml')
      flights = @flightcaster.flight_by_airline('VX', 28)
      flights.total_entries.should == '5'
      flights.total_pages.should == '1'
    end

    should "get flights by airline, flight number, and date" do
      stub_get('/airlines/VX/flights/28/20100226.xml', 'flight_date.xml')
      flights = @flightcaster.flights_by_airline_on('VX', 28, '20100226')
      flights.total_entries.should == '1'
    end

    should "find a flight from one airport to another" do
      stub_get('/airports/PDX/departures/DFW.xml', 'flight_path.xml')
      flights = @flightcaster.flight_path('PDX', 'DFW')
      flights.total_entries.should == '6'
      flights.total_pages.should == '3'
    end

    should "find a flight from one airport to another on a certain day" do
      stub_get('/airports/PDX/departures/DFW/20090911.xml', 'flight_path_date.xml')
      flights = @flightcaster.flight_path_on('PDX', 'DFW', '20090911')
      flights[0].id.should == 2877686
      flights.size.should == 22
    end
  end

  context "Fetching flight" do
    should "get one flight" do
      stub_get('/flights/2858102.xml', 'flight.xml')
      flight = @flightcaster.flight(2858102)
      flight.id.should == 2858102
      flight.status_code.should == 'S'
      flight.flightstats_id.should == '184971694'
    end
  end

  context "Fetching METARs" do
    should "get all METARs" do
      stub_get('/metars.xml', 'metars.xml')
      metars = @flightcaster.metars
      metars.total_entries.should == '350774'
      metars.total_pages.should == '11693'
    end

    should "get one METAR" do
      stub_get('/metars/KPDX.xml', 'metar.xml')
      metar = @flightcaster.metar('KPDX')
      metar.icao_id.should == 'KPDX'
      metar.id.should == '42017199'
    end
  end

  context "Fetching TAFs" do
    should "get all TAFs" do
      stub_get('/tafs.xml', 'tafs.xml')
      tafs = @flightcaster.tafs
      tafs.total_entries.should == '22773'
      tafs.total_pages.should == '760'
    end

    should "get one TAF" do
      stub_get('/tafs/KPDX.xml', 'taf.xml')
      taf = @flightcaster.taf('KPDX')
      taf.icao_id.should == 'KPDX'
      taf.id.should == '1163624'
    end
  end

  context "Fetching delays" do
    should "get all general delays" do
      stub_get('/delays.xml', 'general_delays.xml')
      delays = @flightcaster.delays
      delays.total_entries.should == '2'
      delays[0].id.should == '394071'
    end

    should "get one general delay" do
      stub_get('/delays/KPDX.xml', 'general_delay.xml')
      delay = @flightcaster.delay('KPDX')
      delay.id.should == '394069'
    end

    should "get all ground delays" do
      stub_get('/ground_delays.xml', 'ground_delays.xml')
      ground_delays = @flightcaster.ground_delays
      ground_delays.total_entries.should == '3'
      ground_delays[0].id.should == '373404'
    end

    should "get one ground delay" do
      stub_get('/ground_delays/KPDX.xml', 'ground_delay.xml')
      ground_delay = @flightcaster.ground_delay('KPDX')
      ground_delay.id.should == '373404'
      ground_delay.airport_id.should == '6259'
    end

    should "get all ground stops" do
      stub_get('/ground_stops.xml', 'ground_stops.xml')
      ground_stops = @flightcaster.ground_stops
      ground_stops.total_entries.should == '2'
      ground_stops[0].id.should == '125918'
    end

    should "get one ground stop" do
      stub_get('/ground_stops/KPDX.xml', 'ground_stop.xml')
      ground_stop = @flightcaster.ground_stop('KPDX')
      ground_stop.id.should == '125918'
    end
  end
end
