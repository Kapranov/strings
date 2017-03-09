class API::UsersController < AuthenticationController
  include ActionController::Serialization

  before_action :restrict_access

  def index
    @users = User.all
    render json: Oj.dump(json_for(@users, meta: meta), mode: :compat)
  end

  def show
    @user = User.where(id: params[:id]).first
    if @user
      render json: Oj.dump(json_for(@user, meta: meta), mode: :compat)
    else
      return head :unauthorized
    end
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: Oj.dump(json_for(@user, meta: meta), mode: :compat)
    else
      return head :unauthorized
    end
  end

  def meta
    { copyright: "© #{Time.now.year} LugaTeX -  LaTeX Project Public License (LPPL)." }
  end

  private

  def user_params
    params.permit(
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
