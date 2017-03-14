module API::V3
  class PhonesController < ApiController
    def index
      render json: { message: "Welcome APIs Phones V3" }.to_json, status: :ok
    end
  end
end
