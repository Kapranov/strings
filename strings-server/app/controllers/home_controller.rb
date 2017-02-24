class HomeController < AuthenticationController
  def index
    # @tokens = Token.all
    # render json: @tokens, status: :ok, meta: default_meta
    # render json: MultiJson.dump(json_for(@tokens, status: :ok, meta: default_meta), mode: :compat)
    # render json: Oj.dump(@tokens.first, mode: :compat)
    # render html: "<strong>Everyone can see me!</strong>".html_safe
    render plain: "Everyone can see me!"
  end
end
