require "test_helper"

describe ErrorsController do
  before(:all) do
    Rails.application.config.action_dispatch.show_exceptions = true
    Rails.application.config.consider_all_requests_local = false
  end

  after(:all) do
    Rails.application.config.action_dispatch.show_exceptions = false
    Rails.application.config.consider_all_requests_local = true
  end

  describe "404 page" do
    it { must_respond_with :success }
    #page.status_code.must_equal 404
    #page.must_have_content 'Not Found'
  end

  describe "422 page" do
    it { must_respond_with :success }
  end

  describe "500 page" do
    it { must_respond_with :success }
  end

  #describe "404 page" do
  #  it "is customized" do
  #    get :not_found
  #    expect(page.status_code).to eq 404
  #    expect(page).to have_content("Not Found")
  #  end
  #end
end
