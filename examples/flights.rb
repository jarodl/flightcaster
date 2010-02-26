require File.join(File.dirname(__FILE__), '..', 'lib', 'flightcaster')

flightcaster = FlightCaster.new('MukODwXcOeqMC6c0p6iz')

flights = flightcaster.flights

flights.flight.each do |f|
  puts f.destination
end
