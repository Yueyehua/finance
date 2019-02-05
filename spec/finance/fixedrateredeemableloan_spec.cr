require "../spec_helper"

describe Finance::FixedRateRedeemableLoan do
  it "returns the borrowing capacity given capacity, rate and duration." do
    bc = Finance::FixedRateRedeemableLoan.borrowing_cap(6.22, 0.075, 36)
    bc.should be_a Float64
    bc.should eq 199.96
  end
  it "returns the lean amortizing schedule given fund, rate and duration." do
    # TODO:
  end
  it "returns the monthly interests given remainder and monthly rate." do
    mi = Finance::FixedRateRedeemableLoan.monthly_interests(100, 0.01)
    mi.should be_a Float64
    mi.should eq 1
  end
  it "returns the monthly payment given fund, rate and duration." do
    mp = Finance::FixedRateRedeemableLoan.monthly_payment(200, 0.075, 36)
    mp.should be_a Float64
    mp.should eq 6.22
  end
  it "returns the monthly rate depending on yearly rate." do
    mr = Finance::FixedRateRedeemableLoan.monthly_rate(0.12)
    mr.should be_a Float64
    mr.should eq 0.01
  end
  it "returns the sum of all the interests given fund, rate and duration." do
    tc = Finance::FixedRateRedeemableLoan.total_cost(200, 0.075, 36)
    tc.should be_a Float64
    tc. should eq 23.92
  end
end
