class DashboardsController < AuthenticationController
  def index
    render json: { message: "Welcome Dashboard Page!" }.to_json, status: :ok
  end
end
