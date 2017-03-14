module API::V2
  class UsersController < ApiController
    def index
      render json: { message: "Welcome APIs Users V2" }.to_json, status: :ok
    end
  end
end
