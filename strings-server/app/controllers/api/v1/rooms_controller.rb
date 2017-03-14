module API::V1
  class RoomsController < ApiController
    def index
      render json: { message: "Welcome APIs Rooms V1" }.to_json, status: :ok
    end
  end
end
