class API::UsersController < ApplicationController
  def index
    @users = User.all
    render :json => MultiJson.dump(json_for(@users), mode: :compat)
  end
end
