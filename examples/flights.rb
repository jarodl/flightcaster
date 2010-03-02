require File.join(File.dirname(__FILE__), '..', 'lib', 'flightcaster')

flightcaster = FlightCaster.new('MukODwXcOeqMC6c0p6iz')

flights = flightcaster.flights

puts "All flights:"

# all flights
flights.each do |f|
  puts "Flight: #{f.airline_icao_id}-#{f.number}"
end

puts "*"*50

# all flights going from PDX to DFW
flights = flightcaster.flight_route('PDX', 'DFW')

puts "Flights from PDX to DFW:"

flights.each do |f|
  puts "\nFlight: #{f.airline_icao_id}-#{f.number}"
  puts "Arrival: #{f.published_arrival_time}"
end

puts "*"*50

puts "Flights on VX"

# all flights with a certain airline
flights = flightcaster.flights_by_airline('VX')

flights.each do |f|
  puts "Flight: #{f.airline_icao_id}-#{f.number}"
end
