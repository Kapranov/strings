class UpgradeController < AuthenticationController
  skip_before_action :authenticate

  def index
    render json: { message: "Your browser is Firefox, check it out render!" }
  end
end
