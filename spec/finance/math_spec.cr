require "../spec_helper"

describe Finance::Math do
  it "Calculates the Nth root of a Floating value." do
    v1_n = 2.0 ** 16
    v1 = Finance::Math.nthrt(16, v1_n)
    v1.should be_a Float64
    v1.should eq 2.0
    v2_n = 1.5 ** 72
    v2 = Finance::Math.nthrt(72, v2_n)
    v2.should be_a Float64
    v2.should eq 1.5
  end
  it "returns the periodic interests given an amount and periodic rate." do
    pi = Finance::Math.periodic_interests(100, 0.01)
    pi.should be_a Float64
    pi.should eq 1
  end
  it "returns the periodic rate depending on yearly rate." do
    pr = Finance::Math.periodic_rate(0.12, 12)
    pr.should be_a Float64
    pr.should eq 0.01
  end
end
