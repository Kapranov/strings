class HomeController < AuthenticationController
  skip_before_action :authenticate

  def index
    @tokens = Token.order_by(id: :desc, username: :asc)
    render json: Oj.dump(json_for(@tokens, meta: meta), mode: :compat)
  end
end
