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
end
