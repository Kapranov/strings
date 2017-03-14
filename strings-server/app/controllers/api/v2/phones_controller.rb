module API::V2
  class PhonesController < ApiController
    def index
      render json: { message: "Welcome APIs Phones V2" }.to_json, status: :ok
    end
  end
end
