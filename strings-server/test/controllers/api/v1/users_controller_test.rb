require "test_helper"

describe API::V1::UsersController do
  it "should get index" do
    get api_v1_users_index_url
    value(response).must_be :success?
  end

end
