require 'spec_helper'

describe Scout do
  before(:each) do
    @attr = { :first_name => "Joe", :last_name => "Scout", :birthday => "11/18/1993" }
  end

  it "should create a new instance given valid attributes" do
    Scout.create!(@attr)
  end

  it "should create an active Scout by default" do
    scout = Scout.create!(@attr)
    scout.should be_active
  end

  it "should require a first name" do
    scout = Scout.new(@attr.merge(:first_name => ""))
    scout.should_not be_valid
  end

  describe "ordering" do
    before(:each) do
      @s1 = Scout.create! :first_name => "A", :last_name => "A" 
      @s2 = Scout.create! :first_name => "B", :last_name => "A" 
      @s3 = Scout.create! :first_name => "A", :last_name => "B" 
    end

    it "should order by last, then first" do
      (@s1 <=> @s1).should == 0
      (@s1 <=> @s3).should < 0
      (@s1 <=> @s2).should < 0
    end
  end
end

