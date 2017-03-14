module API::V3
  class RoomsController < ApiController
    def index
      render json: { message: "Welcome APIs Rooms V3" }.to_json, status: :ok
    end
  end
end
