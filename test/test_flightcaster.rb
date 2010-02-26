require 'helper'

class TestFlightCaster < Test::Unit::TestCase

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

    should "get all airlines" do
      stub_get("/airlines.xml?api_key=#{@api_key}", 'airlines.xml')
      airlines = @flightcaster.airlines
      airlines.current_page.should == '1'
      airlines.total_entries.should == '504'
      airlines.total_pages.should == '17'
    end

    should "get airlines on certain page" do
      stub_get("/airlines.xml?api_key=#{@api_key}&page=3", 'airlines_page.xml')
      airlines = @flightcaster.airlines(:page => 3)
      airlines.current_page.should == '3'
    end

    should "get airlines with 50 on each page" do
      stub_get("/airlines.xml?api_key=#{@api_key}&per_page=50", 'airlines_per_page.xml')
      airlines = @flightcaster.airlines(:per_page => 50)
      airlines.airline.size.should == 50
    end

  end

  context "Fetching airline" do
    should "get one airline" do
      stub_get("/airlines/221.xml?api_key=#{@api_key}", 'airline.xml')
      airline = @flightcaster.airline(221)
      airline.callsign.should == 'UNITED'
      airline.name.should == 'United Airlines'
      airline.icao_id.should == 'UAL'
    end

    should "raise error when given invalid airline number" do
      stub_get("/airlines/-10.xml?api_key=#{@api_key}", 'notfound.xml', 404)
      @flightcaster.airline(-10).should raise_error
    end
  end

  context "Fetching airports" do
    should "get all airports" do
      stub_get("/airports.xml?api_key=#{@api_key}", 'airports.xml')
      airports = @flightcaster.airports
      airports.current_page.should == '1'
      airports.total_entries.should == '2026'
      airports.total_pages.should == '68'
      airports.airport[0].city.should == 'New York'
    end
  end

  context "Fetching flights" do
    should "get all flights" do
      stub_get("/flights.xml?api_key=#{@api_key}", 'flights.xml')
      flights = @flightcaster.flights
      flights.flight[0].id.should == 2858102
      flights.flight[0].status == 'Scheduled'
    end
  end
end
