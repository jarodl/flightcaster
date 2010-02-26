require 'helper'

class TestFlightCaster < Test::Unit::TestCase

  API_URI = "http://api.flightcaster.com"
  DIR = File.dirname(__FILE__)

  def setup
    @api_key = "foo"
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
    setup do
      FakeWeb.register_uri(:get, API_URI + "/airlines.xml?api_key=#{@api_key}",
                           :body => File.read(DIR + '/fixtures/airlines.xml'))
    end

    should "get all airlines" do
      airlines = @flightcaster.airlines
      airlines.current_page.should == '1'
      airlines.total_entries.should == '504'
      airlines.total_pages.should == '17'
    end

  end

  context "Fetching airlines with params" do
    setup do
      FakeWeb.register_uri(:get, API_URI + "/airlines.xml?api_key=#{@api_key}&page=3",
                           :body => File.read(DIR + '/fixtures/airlines_page.xml'))
    end

    should "get airlines on certain page" do
      airlines = @flightcaster.airlines(:page => 3)
      airlines.current_page.should == '3'
    end
  end

  context "Fetching airline" do
    setup do
      FakeWeb.register_uri(:get, API_URI + "/airlines/221.xml?api_key=#{@api_key}",
                           :body => File.read(DIR + '/fixtures/airline.xml'))
    end

    should "get one airline" do
      airline = @flightcaster.airline(221)
      airline.callsign.should == 'UNITED'
      airline.name.should == 'United Airlines'
      airline.icao_id.should == 'UAL'
    end
  end

  context "Fetching airports" do
    setup do
      FakeWeb.register_uri(:get, API_URI + "/airports.xml?api_key=#{@api_key}",
                           :body => File.read(DIR + '/fixtures/airports.xml'))
    end

    should "get all airports" do
      airports = @flightcaster.airports
      airports.current_page.should == '1'
      airports.total_entries.should == '2026'
      airports.total_pages.should == '68'
      airports.airport[0].city.should == 'New York'
    end

  end

  context "Fetching flights" do
    setup do
      FakeWeb.register_uri(:get, API_URI + "/flights.xml?api_key=#{@api_key}",
                           :body => File.read(DIR + '/fixtures/flights.xml'))
    end

    should "get all flights" do
      flights = @flightcaster.flights
      flights.flight[0].id.should == 2858102
      flights.flight[0].status == 'Scheduled'
    end

  end
end
