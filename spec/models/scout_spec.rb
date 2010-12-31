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
end

