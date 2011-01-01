require 'spec_helper'

describe BadgerConfig do
  before(:each) do
    BadgerConfig.create!
    @config = BadgerConfig.first
    @attr = {
      :login => "viewer",
      :password => "password",
      :password_confirmation => "password",
      :admin_login => "admin",
      :admin_password => "password2",
      :admin_password_confirmation => "password2"
    }
    @config.attributes = @attr
  end

  describe "password validations" do
    it "should accept valid attributes" do
      @config.should be_valid
    end

    it "should require matching confirmation" do
      @config.password_confirmation = "passwood"
      @config.should_not be_valid
    end

    it "should require matching admin confirmation" do
      @config.admin_password_confirmation = "passwood2"
      @config.should_not be_valid
    end
  end

  describe "password hashing" do
    it "should have hashed password attributes" do
      @config.should respond_to(:hashed_password)
      @config.should respond_to(:hashed_admin_password)
    end

    it "should create hashed passwords on save" do
      @config.save!
      @config.hashed_password.should_not be_blank
      @config.hashed_password.should_not == @config.password
      @config.hashed_admin_password.should_not be_blank
      @config.hashed_admin_password.should_not == @config.admin_password
    end

    it "should cope with initially empty passwords" do
      @config.password = nil
      @config.password_confirmation = nil
      @config.admin_password = nil
      @config.admin_password_confirmation = nil
      @config.save!
    end

    it "should return old passwords on new empty passwords" do
      @config.save!
      hashed_password = @config.hashed_password
      hashed_admin_password = @config.hashed_admin_password

      @config.password = nil
      @config.password_confirmation = nil
      @config.admin_password = ""
      @config.admin_password_confirmation = ""
      @config.save!

      @config.hashed_password.should == hashed_password
      @config.hashed_admin_password.should == hashed_admin_password
    end
  end

  describe "login checks" do
    before(:each) do
      @config.save!
    end

    it "should accept valid viewer login" do
      @config.is_viewer?(@attr[:login], @attr[:password]).should be_true
    end

    it "should reject invalid viewer login" do
      @config.is_viewer?(@attr[:login], "bogus").should be_false
      @config.is_viewer?("bogus", @attr[:password]).should be_false
    end

    it "should accept valid admin login" do
      @config.is_admin?(@attr[:admin_login], @attr[:admin_password]).should be_true
    end

    it "should reject invalid admin login" do
      @config.is_admin?(@attr[:admin_login], "bogus").should be_false
      @config.is_admin?("bogus", @attr[:admin_password]).should be_false
    end
  end
end

