class DashboardsController < AuthenticationController
  def index
    render json: { message: "Welcome Dashboard Page!" }
  end
end
