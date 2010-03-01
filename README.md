FlightCaster
============

The [FlightCaster](http://flightcaster.com) ruby gem. Get started by [signing up for a free API
key](http://docs.flightcaster.com/).

## Examples

    # load your API key
    flightcaster = FlightCaster.new('api_key')

    # retrieve all flights
    flights = flightcaster.flights

    # get a flight by airline and flight number
    flight = flightcaster.flight_by_airline('VX', 28)

See more in the [examples
directory](http://github.com/jarodluebbert/flightcaster/tree/master/examples/).

## Docs

[View the
documentation](http://rdoc.info/projects/jarodluebbert/flightcaster).

### todo

* Load API key from config file
* Authenticate with user/pass

### Note on Patches/Pull Requests

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

### Copyright

Copyright (c) 2010 Jarod Luebbert. See LICENSE for details.

