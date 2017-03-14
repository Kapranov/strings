module API::V1
  class CardsController < ApiController
    def index
      render json: { message: "Welcome APIs Cards V1" }.to_json, status: :ok
    end
  end
end
