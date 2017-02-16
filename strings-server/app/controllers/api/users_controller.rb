class API::UsersController < ApplicationController
  include ActionController::Serialization

  before_action :authenticate
  before_action :validate_token
  before_action :check_header

  def index
    @users = User.all
    render :json => MultiJson.dump(json_for(@users), mode: :compat)
  end
end
