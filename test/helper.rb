require 'rubygems'
require 'test/unit'
require 'shoulda'
require 'matchy'
require 'fakeweb'

FakeWeb.allow_net_connect = false

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'flightcaster'

class Test::Unit::TestCase
end

class FakeRequest
  def code; end

  def message; end
end

class NotFoundRequest < FakeRequest
  def code
    404
  end
end

class OldAPIRequest < FakeRequest
  def code
    422
  end
end
