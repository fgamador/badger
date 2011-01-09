require 'spec_helper'

describe CourtOfHonor do
  describe "first_after" do
    before(:each) do
      @jan = CourtOfHonor.create! :name => "Jan", :date => Date.civil(2000, 1, 1)
      @feb = CourtOfHonor.create! :name => "Feb", :date => Date.civil(2000, 2, 1)
      @mar = CourtOfHonor.create! :name => "Mar", :date => Date.civil(2000, 3, 1)
    end

    it "should return nil if after all courts of honor" do
      CourtOfHonor.first_after(Date.civil(2000, 3, 2)).should be_nil
    end

    it "should return first if before all courts of honor" do
      CourtOfHonor.first_after(Date.civil(1999, 12, 31)).should == @jan
    end

    it "should return second if between first and second" do
      CourtOfHonor.first_after(Date.civil(2000, 1, 2)).should == @feb
    end

    it "should return third if between second and third" do
      CourtOfHonor.first_after(Date.civil(2000, 2, 2)).should == @mar
    end
  end
end

