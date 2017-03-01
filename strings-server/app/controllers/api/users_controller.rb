class API::UsersController < AuthenticationController
  include ActionController::Serialization

  before_action :restrict_access

  def index
    @users = User.all
    render json: MultiJson.dump(json_for(@users, meta: meta), mode: :compat)
  end

  def show
    render json: @users
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
end
