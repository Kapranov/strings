require "test_helper"

describe API::UsersController do
  it "#index go to the page" do
    get api_users_url
    response.status.must_equal 200
  end
end
