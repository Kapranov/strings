module Api::V3
  class UsersController < ApiController
    def index
      @users = User.order_by(email: :desc)
      render json: Oj.dump(json_for(@users, meta: meta), mode: :compat)
    end
  end
end
