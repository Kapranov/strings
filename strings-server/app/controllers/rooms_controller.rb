class RoomsController < AuthenticationController
  #before_action :set_authenticate
  before_action :set_room, only: [:show, :update, :destroy]

  def index
    @rooms = Room.order_by(title: :desc)
    render json: Oj.dump(json_for(@rooms, include: ['cards'], meta: meta), mode: :compat)
  end

  def show
    if @room
      render json: Oj.dump(json_for(@room, include: ['cards'], meta: meta), mode: :compat)
    else
      return head :unauthorized
    end
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      render json: Oj.dump(json_for(@room, include: ['cards'], meta: meta), mode: :compat)
    else
      return head :unauthorized
    end
  end

  def update
    if @room.update(room_params)
      render json: Oj.dump(json_for(@room, include: ['cards'], meta: meta), mode: :compat), message: "Room was updated"
    else
      return head :unauthorized
    end
  end

  def destroy
    if @room.destroy
      render json: { message: "room deleted" }.to_json, status: :ok
    else
      return head :unauthorized
    end
  end

  private

  def set_room
    @room = Room.where(id: params[:id]).first
  end

  def room_params
    params.permit( :id, :title)
  end
end
