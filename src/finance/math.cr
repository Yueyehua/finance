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
  end
end
