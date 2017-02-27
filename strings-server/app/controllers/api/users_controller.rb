class API::UsersController < AuthenticationController
  include ActionController::Serialization

  before_action :restrict_access

  def index
    @users = User.all
    render json: MultiJson.dump(json_for(@users, meta: meta), mode: :compat)
    #
    # user = User.find_for_database_authentication(email: params[:email])
    # if user.valid_password?(params[:password]) and user.is_admin==true
    #   render json: payload(user)
    # else
    #   render json: {errors: ['Invalid Username/Password']}, status: :unauthorized
    # end
  end

  def show
    render json: user
  end

  def ping
    render json: {
      message: "All good. You only get this message if you're authenticated.",
      user: @current_user
    }
  end

  def meta
    {
      copyright: "© #{Time.now.year} LugaTeX -  LaTeX Project Public License (LPPL)."
    }
  end

  private

  def user_param
    params.required(:user).permit(
      :first_name,
      :last_name,
      :middle_name,
      :password,
      :apikey,
      :email,
      :description,
      :role
    )
  end

  def user
    User.find(params[:id])
  end

  def apikey?
    !params[:token].blank?
  end

  def payload(user)
    return nil unless user and user.id
    {
      auth_token: JsonWebToken.encode({user_id: user.id}),
      user: {id: user.id, email: user.email}
    }
  end
end
