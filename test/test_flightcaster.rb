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
  end

  context "Fetching flights" do
  end
end
