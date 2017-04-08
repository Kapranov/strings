class AuthenticationController < ApplicationController
  #before_action :set_email, only: [:login]
  #before_action :set_authenticate, only: [:set_authenticate]

  #def set_authenticate(realm=nil)
  #  if realm
  #    self.headers['WWW-Authenticate'] = %(Token realm="#{realm.gsub(/"/, "")}")
  #  end
  #
  #  render json: { errors: ["Bad credentials"] }.to_json, status: 401 unless user_signed_in?
  #end

  def user_signed_in?
    !!current_user
  end

  def current_user
    @current_user ||= User.find(decoded_token[:id]) if id_found?
  rescue
    nil
  end

  def register
    @user = User.new(user_params)
    if @user.save
      token = JsonWebToken.encode({id: @user.id})
      render json: { token: token, user: UserSerializer.new(@user) }.to_json, status: :ok
    else
      render json: { errors: ["Unprocessable Entity"]}.to_json, status: 422
    end
  end

  def login
    if @user && @user.authenticate(params[:password])
      token = JsonWebToken.encode({id: @user.id})
      render json: { token: token, user: UserSerializer.new(@user) }.to_json, status: :ok
    else
      render json: { errors: ["Invalid login credentials."]}.to_json, status: 401
    end
  end

  private

  def set_email
    @user = User.where(email: params[:email]).first
  end

  def user_params
    params.permit(
      :id,
      :email,
      :last_name,
      :password,
      :password_digest
    )
  end

  def id_found?
    token && decoded_token && decoded_token[:id]
  end

  def decoded_token
    @decoded_token ||= JsonWebToken.decode(token) if token
  end

  def token
     @token ||= if request.headers['Authorization'].present?
                  request.headers['Authorization'].split.last
                end
  end

  #def admin_only
  #  unless @current_user.admin == true
  #    render json: { message: "Access denied" }.to_json
  #  end
  #end

  def validate_token
    token = request.headers["Authorization"]
    return unless token
    api_token = User.where.first[:api_token]
    updated_at = User.where.first[:updated_at]
    api_token = token
    return unless api_token
    if 15.minutes.ago < updated_at
      @token = token
    end
  end

  def check_header
    if ['GET','POST','PUT','PATCH'].include? request.method
      if request.content_type != "application/vnd.api+json"
        head 406 and return
      end
    end
  end

  def restrict_access
    token = User.where(api_token: params[:token])
    auth_header = request.headers['Authorization']
    params[:token] = token

    if token.present?
      auth_header ? auth_header.split(' ').last : nil
    else
      render json: { error: 'Incorrect credentials', meta: meta }.to_json, status: 401
    end
  end
end
