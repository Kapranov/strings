class PhonesController < AuthenticationController
  #before_action :set_authenticate
  before_action :set_phone, only: [:show, :update, :destroy]

  def index
    user = User.where(id: params[:user_id]).first
    @phones = user.phones.order_by(name: :asc)

    if params[:filter]
      @phones = user.phones.where(["category = ?", params[:filter]])
    end

    if @phones
      render json: Oj.dump(json_for(@phones, meta: meta), mode: :compat)
    else
      return head :unauthorized
    end
  end

  def show
    if @phone
      render json: Oj.dump(json_for(@phone, meta: meta), mode: :compat)
    else
      return head :unauthorized
    end
  end

  def new
    user = User.where(id:params[:user_id]).first
    @phone = user.phones.new
  end

  def create
    user = User.where(id: params[:user_id]).first
    @phone = user.phones.new(phone_params)

    if @phone.save
      #render json: @phone, status: :created, meta: meta, location: @phone
      render json: Oj.dump(json_for(@phone, meta: meta, location: @phone), mode: :compat), status: :created
    else
      return head :unauthorized
    end
  end

  def update
    user = User.where(id: params[:user_id]).first
    @phone = user.phones.where(id: params[:id]).first

    if @phone.update(phone_params)
      #render json: @phone, status: :ok, location: @phone
      render json: Oj.dump(json_for(@phone, meta: meta, location: @phone), mode: :compat), status: :ok, message: "Phone was updated"
    else
      return head :unauthorized
    end
  end

  def destroy
    user = User.where(id: params[:user_id]).first
    @phone = user.phones.where(id: params[:id]).first

    if @phone.destroy
      render json: { message: "Phone was deleted" }.to_json, status: :ok
    else
      return head :unauthorized
    end
  end

  private

  def set_phone
    user = User.where(id: params[:user_id]).first
    @phone = user.phones.where(id: params[:id]).first
  end

  def phone_params
    params.permit(:id, :user_id, :name, :phone_number)
  end
end
