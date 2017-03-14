class UsersController < AuthenticationController
  before_action :set_authenticate
  before_action :set_user,  only: [:show, :update, :destroy]
  before_action :admin_only, except: [:show, :update]

  def index
    @users = User.order_by(username: :desc)
    if @users
      render json: Oj.dump(json_for(@users, include: ['cards', 'phones'], meta: meta), mode: :compat)
    else
      return head :unauthorized
    end
  end

  def show
    if @user
      render json: Oj.dump(json_for(@user, include: ['cards', 'phones'], meta: meta), mode: :compat)
    else
      return head :unauthorized
    end

    unless @current_user.admin == true
      unless @user == @current_user
        render json: { message: "Access denied." }.to_json
      end
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: Oj.dump(json_for(@user, include: ['cards', 'phones'], meta: meta), mode: :compat)
    end
  end

  def destroy
    if @user.destroy
      render json: { message: "User was deleted" }.to_json, status: :ok
    else
      return head :unauthorized
    end
  end

  def update
    if @user.update(user_params)
      render json: Oj.dump(json_for(@user, include: ['cards', 'phones'], meta: meta), mode: :compat), message: "User was updated"
    end
    unless @current_user.admin == true
      unless @user == @current_user
        render json: { message: "Access denied." }.to_json
      end
    end
  end

  private

  def set_user
    @user = User.where(id: params[:id]).first
  end

  def user_params
    params.permit(
      :id,
      :email,
      :first_name,
      :last_name,
      :middle_name,
      :password,
      :password_digest,
      :auth_token,
      :description,
      :role,
      :state,
      :admin
    )
  end
end
