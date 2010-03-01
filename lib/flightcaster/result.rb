module FlightCaster
  class Rash
    extend Forwardable

    attr_accessor :hash, :array

    def initialize(h)
      @array = []
      @hash = h
      split_into_rash
    end

    def_delegators :@hash, :id, :replace, :each_key, :keys, :delete,
                   :merge!, :method_missing
    def_delegators :@array, :each, :size, :[]

    private

    def split_into_rash
      @hash.each_key do |key|
        if @hash[key].class == Array
          @hash[key].each {|x| @array << x}
          @hash.delete(key)
        elsif @hash[key].class == Hashie::Mash
          @hash[key] = Rash.new(@hash[key])
        end
      end
    end

  end
end
