class API::UsersController < AuthenticationController
  include ActionController::Serialization

  before_action :restrict_access

  def index
    @users = User.all
    render json: MultiJson.dump(json_for(@users, meta: meta), mode: :compat)
  end

  def show
    @user = User.find(params[:id])
    render json: @user
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: :ok
    end
  end

  def meta
    {
      copyright: "© #{Time.now.year} LugaTeX -  LaTeX Project Public License (LPPL)."
    }
  end

  private

  def user_params
    hash = {}
    hash.merge! params.slice(
      :first_name,
      :last_name,
      :middle_name,
      :password,
      :apikey,
      :email,
      :description,
      :role
    )
    hash
  end
end
