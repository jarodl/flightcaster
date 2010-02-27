module FlightCaster
  class Result
    extend Forwardable

    def initialize(data)
      @h = generate_hash(data)
    end

    def_delegators :@h, :id, :replace, :each_key, :keys, :delete,
                        :[], :[]=, :merge!, :method_missing

    # When enumerating a hash, look for an array with the
    # response results and pass it the block.
    def each(&blk)
      @h.results.each(&blk)
    end

    def [](key)
      @h.results[key]
    end

    def size
      @h.results.size
    end

    private

    def generate_hash(data)
      h = Hashie::Mash.new(data)
      # since the hash looks like { :airlines => { stuff we want } },
      # we just grab the value from the first key
      h = h[h.keys[0]]
      # now we have:
      # { :total_entries => 1, ... , :data_requested => [array of hashes], }
      # for example if the user requests `.flights` then in order to
      # iterate over all flights `.flights.flight.each` would be needed.
      # To get around this, we need to grab out that array of hashes
      # and store it in a general location so we can overload `.each`
#      h.each_key do |key|
#        if h[key].class == Array
#          results = []
#          h[key].each do |item|
#            results << item
#          end
#          h.delete(key)
#          h.merge!({ :results => results })
#        end
#      end
      extract_array!(h)
    end

    def extract_array!(h)
      h.each_key do |key|
        if h[key].class == Array
          results = []
          h[key].each do |item|
            results << item
          end
          h.delete(key)
          h.merge!({ :results => results })
        elsif h[key].class == Hashie::Mash
          h[key].each_key do |k|
            tmp = h[key].send(k)
            if tmp.class == Array
              arr = []
              tmp.each do |item|
                arr << item
              end
              h[key] = arr
            end
          end
        end
      end
    end
  end
end
