require 'rubygems'
gem 'httparty', '~> 0.5.2'
require 'httparty'
gem 'hashie', '~> 0.1.8'
require 'hashie'

[ "base",
  "request" ].each do |file|
  require File.join(File.dirname(__FILE__), 'flightcaster', file)
end

module FlightCaster
  def self.new(*params)
    FlightCaster::Base.new(*params)
  end
end
