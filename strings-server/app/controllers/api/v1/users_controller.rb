module API::V1
  class UsersController < ApiController
    def index
      render json: { message: "Welcome APIs Users V1" }.to_json, status: :ok
    end
  end
end
