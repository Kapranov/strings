class ProfilesController < AuthenticationController
  def index
    render json: { message: "Welcome Profile Page!" }
  end
end
