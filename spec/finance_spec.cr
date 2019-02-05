require "./spec_helper"
require "./finance/**"

describe Finance do
  it "has a version number" do
    Finance::VERSION.should_not be_nil
  end
end
