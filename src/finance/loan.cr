module Finance
  # Collection of formulas used for a fixed rate redeemable loan.
  module Loan
    extend self

    # Returns the borrowing capacity given the monthly payment capacity,
    # the yearly rate and the duration of the loan in month.
    #
    # ```
    # Finance::Loan.borrowing_cap(1, 0.12, 12) # => 11.26
    # ```
    def borrowing_cap(capacity : Float64, rate : Float64, duration : Int32)
      r = Finance::Math.periodic_rate(rate, 12)
      (capacity * ((1 - (1 + r) ** -(duration)) / r)).round(2)
    end

    # Returns the loan schedule given the fund borrowed, the yearly rate and
    # the duration of the loan in month.
    #
    # ```
    # Finance::Loan.loan_schedule(100, 0.12, 12)
    # ```
    def loan_schedule(fund : Float64, rate : Float64, duration : Int32,
                      date = Time.now)
      schedule = [{date, 0, 0, 0.0, 0.0, fund}]
      due = monthly_payment(fund, rate, duration)
      duration.times do |i|
        remainder = schedule.last.last
        target_date = schedule.last.first + 1.month
        line = schedule_line(remainder, rate, due, target_date, i, duration)
        schedule.push line
      end
      schedule
    end

    # Returns the monthly payment due given the fund borrowed, the yearly rate
    # and the duration of the loan in month.
    #
    # ```
    # Finance::Loan.monthly_payment(100, 0.12, 12) # => 8.88
    # ```
    def monthly_payment(fund : Float64, rate : Float64, duration : Int32)
      r = Finance::Math.periodic_rate(rate, 12)
      (fund * (r / (1 - (1 + r) ** -(duration)))).round(2)
    end

    # Returns the total cost of the loan, i.e. the sum of all the monthly
    # interests given the fund borrowed, the yearly rate and the duration
    # of the loan in month.
    #
    # ```
    # Finance::Loan.total_cost(100, 0.12, 12) # => 6.56
    # ```
    def total_cost(fund : Float64, rate : Float64, duration : Int32)
      mp = monthly_payment(fund, rate, duration)
      (mp * duration - fund).round(2)
    end

    # :nodoc:
    private def schedule_line(asset, rate, payment, date, iterator, duration)
      nth_year = iterator / 12
      nth_month = iterator % 12
      monthly_rate = Finance::Math.periodic_rate(rate, 12)
      interests = Finance::Math.periodic_interests(asset, monthly_rate)
      remainder = (asset + interests - payment).round(2)
      due = iterator + 1 != duration ? payment : (payment + remainder).round(2)
      rem = iterator + 1 != duration ? remainder : 0.0
      {date, nth_year, nth_month, due, interests, rem}
    end
  end
end
