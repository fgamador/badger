require 'spec_helper'

describe "NavLinks" do
  it "should have Scouts page as home page" do
    get '/'
    response.should be_success
    response.should have_selector("title",
      :content => "Badger: Scouts")
  end

  it "should have Scouts page" do
    get '/scouts'
    response.should be_success
    response.should have_selector("title",
      :content => "Badger: Scouts")
  end
end

