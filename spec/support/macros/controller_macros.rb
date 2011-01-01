module ControllerMacros
  def add_authentication_credentials
    @request.env["HTTP_AUTHORIZATION"] =
      ActionController::HttpAuthentication::
      Basic.encode_credentials('trustworthy', 'loyal')
  end

  def should_return_401_for_unauthenticated(test_controller)
    describe test_controller, "authentication requests" do
      it "should return 401 for show" do
        get :show
        response.code.should == "401"
      end
      it "should return 401 for create" do
        post :create
        response.code.should == "401"
      end
    end
  end
end

