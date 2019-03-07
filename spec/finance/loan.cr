require "../spec_helper"

describe Finance::Loan do
  it "returns the borrowing capacity given capacity, rate and duration." do
    bc = Finance::Loan.borrowing_cap(6.22, 0.075, 36)
    bc.should be_a Float64
    bc.should eq 199.96
  end
  it "returns the lean amortizing schedule given fund, rate and duration." do
    t = Time.new(2019, 2, 1)
    ls = Finance::Loan.loan_schedule(10.0, 0.01, 3, t)
    ls.should be_a Array({Time, Int32, Int32, Float64, Float64, Float64})
    ls.should eq [
      {Time.new(2019, 2, 1), 0, 0, 0.0, 0.0, 10.0},
      {Time.new(2019, 3, 1), 0, 0, 3.34, 0.01, 6.67},
      {Time.new(2019, 4, 1), 0, 1, 3.34, 0.01, 3.34},
      {Time.new(2019, 5, 1), 0, 2, 3.34, 0.0, 0.0},
    ]
  end
  it "returns the monthly payment given fund, rate and duration." do
    mp = Finance::Loan.monthly_payment(200, 0.075, 36)
    mp.should be_a Float64
    mp.should eq 6.22
  end
  it "returns the sum of all the interests given fund, rate and duration." do
    tc = Finance::Loan.total_cost(200, 0.075, 36)
    tc.should be_a Float64
    tc.should eq 23.92
  end
end
