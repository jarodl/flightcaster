require 'helper'

class TestRequest < Test::Unit::TestCase
  context "Requesting" do
    setup do
      @not_found = NotFoundRequest.new
      @old_api = OldAPIRequest.new
    end

    should "add API key to base_uri" do
      FlightCaster::Request.set_api_key("foo")
      FlightCaster::Request.full_uri('/').should == "http://api.flightcaster.com/?api_key=foo"
    end

    should "raise NotFound error" do
      FlightCaster::Request.make_friendly(@not_found).should raise_error
    end

    should "raise OldAPI error" do
      FlightCaster::Request.make_friendly(@old_api).should raise_error
    end
  end
end
