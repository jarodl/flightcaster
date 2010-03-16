require 'test/unit'
require 'shoulda'
require 'matchy'
require 'fakeweb'
begin; require 'turn'; rescue LoadError; end

FakeWeb.allow_net_connect = false

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'flightcaster'

class Test::Unit::TestCase
end

def flightcaster_url(path, params)
  "http://api.flightcaster.com#{path}?api_key=foo&api_version=0.1.1#{params}"
end

def fixture_file(filename)
  return '' if filename == ''
  file_path = File.expand_path(File.dirname(__FILE__) + '/fixtures/' + filename)
  File.read(file_path)
end

def stub_get(path, filename, params='', status=nil)
  options = {:body => fixture_file(filename)}
  options.merge!({:status => status}) unless status.nil?

  FakeWeb.register_uri(:get, flightcaster_url(path, params), options)
end
