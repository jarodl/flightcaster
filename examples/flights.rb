require File.join(File.dirname(__FILE__), '..', 'lib', 'flightcaster')

flightcaster = FlightCaster.new('secret')

flights = flightcaster.flights

# all flights
flights.each do |f|
  puts "#{f.airline_icao_id}-#{f.number}"
end

puts "*"*50

# all flights going from PDX to DFW
flights = flightcaster.flight_path('PDX', 'DFW')

flights.each do |f|
  puts "#{f.airline_icao_id}-#{f.number}"
end

puts "*"*50

# all flights with a certain airline
flights = flightcaster.flights_by_airline('VX')

flights.each do |f|
  puts "#{f.airline_icao_id}-#{f.number}"
end
