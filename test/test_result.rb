require 'helper'

class TestResult < Test::Unit::TestCase
  def setup
    stub_get('/flights.xml', 'flights.xml')
    FlightCaster::Request.set_api_key('foo')
    @flights = FlightCaster::Request.get('/flights.xml')
  end

  context "Initialization" do
    should "require data" do
      lambda { FlightCaster::Result.new }.should raise_error
    end
  end

  context "After initialization, Result" do
    should "get rid of the outside hash" do
      @flights.flights.should == nil
    end

    should "extract arrays from hashes" do
      @flights[0].id.should == 2858102
      @flights[1].id.should == 2856793
    end

    should "not create duplicates" do
      @flights.flight.should == nil
    end

    should "not remove current page number" do
      @flights.current_page.should == '1'
    end

    should "not remove number of entries" do
      @flights.total_entries.should == '504'
    end

    should "not remove number of pages" do
      @flights.total_pages.should == '17'
    end

    should "return the size of the array" do
      @flights.size.should == 30
    end

    should "not duplicate inner arrays" do
    end
  end
end
