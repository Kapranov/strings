require "minitest_helper"

def app
  Rails.application
end

describe "API User integration" do
  it "should list users index" do
     user_creation_count = 1

     get '/api/users'

     assert last_response.successful?
     assert last_response_json['users'].count.must_equal user_creation_count
  end
end
