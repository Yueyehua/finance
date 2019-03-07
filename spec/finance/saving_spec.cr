require "../spec_helper"

describe Finance::Saving do
  it "Returns the interests for a year given a capital and a rate" do
    yi = Finance::Saving.yearly_interests(1200, 0.01)
    yi.should be_a Float64
    yi.should eq 12.0
  end
  it "Returns the interests given a capital, a rate and a monthly payments" do
    yi = Finance::Saving.yearly_interests(1200, 0.01, 100.0)
    yi.should be_a Float64
    yi.should eq 18.49
  end
  it "Returns the savings given monthly payments, rate and monthly payments" do
    yi = Finance::Saving.savings_for_one_year(100, 0.01)
    yi.should be_a Float64
    yi.should eq 1206.49
  end
  it "Returns the interests given a monthly payments, a rate and a duration" do
    yi = Finance::Saving.savings_for_n_years(100, 0.01, 10)
    yi.should be_a Float64
    yi.should eq 12622.56
  end
end
