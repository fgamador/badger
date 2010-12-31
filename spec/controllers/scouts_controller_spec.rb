require 'spec_helper'

describe ScoutsController do
  render_views

  before(:each) do
    add_authentication_credentials
  end

  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end

    it "should have the right title" do
      get 'index'
      response.should have_selector("title",
        :content => "Badger: Scouts")
    end
  end
end

