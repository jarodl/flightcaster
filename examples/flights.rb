require File.join(File.dirname(__FILE__), '..', 'lib', 'flightcaster')

flightcaster = FlightCaster.new('secret')

flights = flightcaster.flights

flights.flight.each do |f|
  puts f.status_code
end
