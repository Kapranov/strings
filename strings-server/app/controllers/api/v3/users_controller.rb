module API::V3
  class UsersController < ApiController
    def index
      render json: { message: "Welcome APIs Users V3" }.to_json, status: :ok
    end
  end
end
