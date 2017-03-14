module API::V3
  class CardsController < ApiController
    def index
      render json: { message: "Welcome APIs Cards V3" }.to_json, status: :ok
    end
  end
end
