class PhonesController < AuthenticationController
  before_action :set_authenticate
  before_action :set_phone, only: [:show, :edit, :update, :destroy]

  def index
    @phones = Phone.all
    render json: Oj.dump(json_for(@phones, meta: meta), mode: :compat)
  end

  def show
    if @phone
      render json: Oj.dump(json_for(@phone, meta: meta), mode: :compat)
    else
      return head :unauthorized
    end
  end

  def new
    @user = User.where(id:params[:user_id]).first
    @phone = @user.phones.new
  end

  def edit
  end

  def create
    @user = User.where(id: params[:user_id]).first
    @phone = @user.phones.new(phone_params)

    if @phone.save
      render json: :show, status: :created, location: @phone
    else
      return head :unauthorized
    end
  end

  def update
    if @phone.update(phone_params)
      render json: :show, status: :ok, location: @phone
    else
      return head :unauthorized
    end
  end

  def destroy
    if @phone.destroy
      render json: { message: "Phone was deleted" }.to_json, status: :ok
    else
      return head :unauthorized
    end

  end

  private

  def set_phone
    @user = User.where(id: params[:user_id]).first
    @phone = @user.phones.where(id: params[:id]).first
  end

  def phone_params
    params.permit(:id, :user_id, :name, :phone_number)
  end
end
