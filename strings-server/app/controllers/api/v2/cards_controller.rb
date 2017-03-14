module API::V2
  class CardsController < ApiController
    def index
      render json: { message: "Welcome APIs Cards V2" }.to_json, status: :ok
    end
  end
end
