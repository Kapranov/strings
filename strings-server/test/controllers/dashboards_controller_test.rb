require "test_helper"

describe DashboardsController do
  describe "GET :index" do
    before do
      get :index, format: :json
    end

    it "should be successful" do
      must_respond_with :success
    end
    #it { must_respond_with :success }

    it "should return the correct message when is passed" do
      body = JSON.parse(response.body)
      welcome_text = "Welcome Dashboard Page!"
      body["message"].must_equal welcome_text
    end
  end
end
