module Api::V2
  class UsersController < ApiController
    def index
      @users = User.all
      render json: @users
    end
  end
end
