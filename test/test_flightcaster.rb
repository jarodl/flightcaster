require 'helper'

class TestFlightCaster < Test::Unit::TestCase

  API_URI = "http://api.flightcaster.com"
  DIR = File.dirname(__FILE__)

  context "Initialization" do
    should "require an API key" do
      lambda { FlightCaster.new }.should raise_error

      FlightCaster.new("foo").api_key.should == "foo"
    end
  end

  context "Fetching airlines" do
    setup do
      api_key = "foo"
      FakeWeb.register_uri(:get, API_URI + "/airlines.xml?api_key=#{api_key}",
                           :body => File.read(DIR + '/fixtures/airlines.xml'))
      @flightcaster = FlightCaster.new("foo")
    end

    should "get all airlines" do
      airlines = @flightcaster.airlines
      airlines.current_page.should == '1'
      airlines.total_entries.should == '504'
      airlines.total_pages.should == '17'
    end
  end

  context "Fetching airports" do
  end

  context "Fetching flights" do
  end
end
