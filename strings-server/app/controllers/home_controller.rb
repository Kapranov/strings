class HomeController < AuthenticationController
  skip_before_action :authenticate

  def index
    # @tokens = Token.all
    # render json: @tokens, status: :ok, meta: default_meta
    # render json: MultiJson.dump(json_for(@tokens, status: :ok, meta: default_meta), mode: :compat)
    # render json: Oj.dump(@tokens.first, mode: :compat)
    # render json: { current_user: @current_user }
    # render json: { message: "All good. You only get this message if you're authenticated.", user: @current_user }, status: 200
    # render html: "<strong>Everyone can see me!</strong>".html_safe
    render plain: "Everyone can see me!"
  end
end
