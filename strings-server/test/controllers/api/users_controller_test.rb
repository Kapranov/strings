require "test_helper"

describe API::UsersController do
  it "#index go to the page" do
    get api_users_url
    assert_response :success
  end
end

class Api::UsersControllerTest < ActionController::TestCase

  def index
    # get :index, { id: users(:one).id }
    get :index, { id: users(:one).id }
    # get api_users_url

    assert_response :success
    assert_equal Mime::JSON, response.content_type

    json = JSON.parse(response.body)
    user_json = json["users"].first

    the_user = users(:one)
    assert_equal the_user.id, user_json["id"]
    assert_equal the_user.first_name, user_json["first_name"]
    assert_equal the_user.last_name, user_json["last_name"]
    assert_equal the_user.middle_name, user_json["middle_name"]
    assert_equal the_user.apikey, user_json["apikey"]
    assert_equal the_user.email, user_json["email"]
    assert_equal the_user.description, user_json["description"]
  end

end
