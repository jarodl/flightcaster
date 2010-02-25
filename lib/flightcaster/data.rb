module FlightCaster
  class Data
    attr_reader :raw, :parsed

    def initialize(response)
      @raw = response.body
      raise_errors(response)
      @parsed = parse(@raw)
    end

    def method_missing(method)
      @parsed[method.to_s]
    end

    private


  end
end
