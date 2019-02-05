module Finance
  # Collection of formulas used for a fixed rate redeemable loan.
  module FixedRateRedeemableLoan
    extend self

    # Returns the borrowing capacity given the monthly payment capacity,
    # the yearly rate and the duration of the loan in month.
    #
    # ```
    # Finance::FixedRateRedeemableLoan.borrowing_cap(1, 0.12, 12) # => 11.26
    # ```
    def borrowing_cap(capacity : Float64, rate : Float64, duration : Int32)
      r = monthly_rate(rate)
      (capacity * ((1 - (1 + r) ** -(duration)) / r)).round(2)
    end

    # Returns the loan schedule given the fund borrowed, the yearly rate and
    # the duration of the loan in month.
    #
    # ```
    # Finance::FixedRateRedeemableLoan.loan_schedule(100, 0.12, 12)
    # ```
    def loan_schedule(fund : Float64, rate : Float64, duration : Int32,
      date = Time.now)
      # TODO: array of {date, nthyear, mthmonth, interests, remainder}
      schedule = [{date, 0, 0, 0.0, 0.0, fund}]
      monthly_due = monthly_payment(fund, rate, duration)
      duration.times do |i|
        remainder = schedule.last.last
        target_date = schedule.last.first + 1.month
        line = schedule_line(remainder, rate, monthly_due, target_date, i)
        schedule.push line
      end
      schedule
    end

    # Returns the monthly interests due given the remainder and
    # the monthly rate.
    #
    # ```
    # Finance::FixedRateRedeemableLoan.monthly_interests(100, 0.01) # => 1.0
    # ```
    def monthly_interests(remainder : Float64, monthly_rate : Float64)
      (remainder * monthly_rate).round(2)
    end

    # Returns the monthly payment due given the fund borrowed, the yearly rate
    # and the duration of the loan in month.
    #
    # ```
    # Finance::FixedRateRedeemableLoan.monthly_payment(100, 0.12, 12) # => 8.88
    # ```
    def monthly_payment(fund : Float64, rate : Float64, duration : Int32)
      r = monthly_rate(rate)
      (fund * (r / (1 - (1 + r) ** -(duration)))).round(2)
    end

    # Returns the monthly rate given the yearly rate.
    #
    # ```
    # Finance::FixedRateRedeemableLoan.monthly_rate(0.12) # => 0.01
    # ```
    def monthly_rate(rate : Float64)
      # Alternative formula: Finance::Math.nthrt(12, 1.0 + yearly_rate) - 1
      rate / 12
    end

    # Returns the total cost of the loan, i.e. the sum of all the monthly
    # interests given the fund borrowed, the yearly rate and the duration
    # of the loan in month.
    #
    # ```
    # Finance::FixedRateRedeemableLoan.total_cost(100, 0.12, 12) # => 6.56
    # ```
    def total_cost(fund : Float64, rate : Float64, duration : Int32)
      mp = monthly_payment(fund, rate, duration)
      (mp * duration - fund).round(2)
    end

    # :nodoc:
    private def schedule_line(asset, rate, payment, date, iteration)
      nth_year = iteration / 12
      nth_month = iteration % 12
      interests = monthly_interests(asset, monthly_rate(rate))
      remainder = (asset + interests - payment).round(2)
      { date, nth_year, nth_month, payment, interests, remainder }
    end
  end
end
