module API::V2
  class RoomsController < ApiController
    def index
      render json: { message: "Welcome APIs Rooms V2" }.to_json, status: :ok
    end
  end
end
