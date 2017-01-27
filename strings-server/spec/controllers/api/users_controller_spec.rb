require 'rails_helper'

RSpec.describe API::UsersController, type: :controller do
  it "#index page for users" do
    get api_users_url
    response.status.must_equal 200
  end
end
