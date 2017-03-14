module API::V1
  class PhonesController < ApiController
    def index
      render json: { message: "Welcome APIs Phones V1" }.to_json, status: :ok
    end
  end
end
