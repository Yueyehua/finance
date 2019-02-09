module Finance
  # Collection of specific mathemathical functions.
  module Math
    extend self

    # Returns the Nth root of value.
    #
    # ```
    # Finance::Math.nthrt(4, 16) # => 2.0
    # ```
    def nthrt(n : Int32, value : Float64, precision = 1e-10)
      x = value
      loop do
        prev = x
        x = ((n - 1) * prev + value / (prev ** (n - 1))) / n
        break unless (prev - x).abs > precision
      end
      x
    end

    # Returns the periodic interests due given the remainder and
    # the periodic rate.
    #
    # ```
    # Finance::Math.periodic_interests(100, 0.01) # => 1.0
    # ```
    def periodic_interests(capital : Float64, periodic_rate : Float64)
      (capital * periodic_rate).round(2)
    end

    # Returns the periodic compound rate given the yearly rate.
    #
    # ```
    # Finance::Math.periodic_compound_rate(0.12, 12) # => 0.009488792934582824
    # ```
    def periodic_compound_rate(rate : Float64, periods : Int32)
      nthrt(periods, 1.0 + rate) - 1
    end

    # Returns the periodic rate given the yearly rate.
    #
    # ```
    # Finance::Math.periodic_rate(0.12, 12) # => 0.01
    # ```
    def periodic_rate(rate : Float64, periods : Int32)
      rate / periods
    end
  end
end
