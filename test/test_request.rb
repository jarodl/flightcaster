require 'helper'

class TestRequest < Test::Unit::TestCase
  context "Requesting" do
    should "add API key to base_uri" do
      FlightCaster::Request.set_api_key("foo")
      FlightCaster::Request.full_uri('/').should == "http://api.flightcaster.com/?api_key=foo"
    end
  end
end

