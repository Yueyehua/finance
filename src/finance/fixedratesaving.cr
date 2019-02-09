module Finance
  # Collection of formulas used for a fixed rate saving.
  module FixedRateSaving
    extend self

    # Returns the total interests for a single year given an existing capital,
    # a yearly rate and a fixed amount of savings per month.
    #
    # ```
    # Finance::FixedRateSaving.yearly_interests(100.0, 0.05, 100.0) # => 37.26
    # ```
    def yearly_interests(capital : Float64, rate : Float64,
                         monthly_savings = 0.0)
      invested = monthly_savings * 12
      total_savings = savings_for_one_year(monthly_savings, rate)
      new_invests_interests = total_savings - invested
      (capital * rate + new_invests_interests).round(2)
    end

    # Returns the total savings of a year given a fixed amount of savings
    # per month and a yearly rate.
    #
    # ```
    # Finance::FixedRateSaving.savings_for_one_year(100.0, 0.05) # => 1232.26
    # ```
    def savings_for_one_year(amount : Float64, rate : Float64)
      savings_for_n_years(amount, rate, 1)
    end

    # Returns the total savings given a fixed amount of savings per month,
    # a yearly rate and the duration in years.
    #
    # ```
    # Finance::FixedRateSaving.savings_for_n_years(100.0, 0.05, 2) # => 2526.13
    # ```
    def savings_for_n_years(amount : Float64, rate : Float64, duration : Int32)
      power = duration * 12 + 1
      ratio = 1 + Finance::Math.periodic_compound_rate(rate, 12)
      (amount * (((1 - ratio ** (power)) / (1 - ratio)) - 1)).round(2)
    end
  end
end
