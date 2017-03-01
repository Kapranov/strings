class HomeController < AuthenticationController
  skip_before_action :authenticate
  # before_action :authenticate_user

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

  def authenticate_user
    render json: { errors: ["Unauthorized"] }, status: 401 unless user_signed_in?
  end

  def user_signed_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find(decoded_token[:id]) if id_found?
  rescue
    nil
  end

  private

  def id_found?
    token && decoded_token && decoded_token[:id]
  end

  def decoded_token
    @decoded_token ||= Auth.decode(token) if token
  end

  def token
    @token ||= if request.headers['Authorization'].present?
                 request.headers['Authorization'].split.last
               end
  end
end
