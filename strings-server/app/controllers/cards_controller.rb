class CardsController < AuthenticationController
  #before_action :set_authenticate
  before_action :set_card, only: [:show, :update, :destroy]

  def index
    #@cards = Card.order_by(content: :desc)
    user = User.where(id: params[:user_id]).first
    @cards = user.cards

    if @cards
      render json: Oj.dump(json_for(@cards, meta: meta), mode: :compat)
    else
      return head :unauthorized
    end
  end

  def show
    if @card
      render json: Oj.dump(json_for(@card, meta: meta), mode: :compat)
    else
      return head :unauthorized
    end
  end

  def new
    user = User.where(id: params[:user_id]).first
    @card = user.cards.new
  end

  def create
    #@card = Card.new(card_params)
    user = User.where(id: params[:user_id]).first
    @card = user.cards.new(card_params)

    if @card.save
      render json: Oj.dump(json_for(@card, meta: meta), mode: :compat)
    else
      return head :unauthorized
    end
  end

  def update
    user = User.where(id: params[:user_id]).first
    @card = user.cards.where(id: params[:id]).first

    if @card.update(card_params)
      render json: Oj.dump(json_for(@card, meta: meta), mode: :compat)
    else
      return head :unauthorized
    end
  end

  def destroy
    user = User.where(id: params[:user_id]).first
    @card = user.cards.where(id: params[:id]).first

    if @card.destroy
      render json: { message: "card deleted" }.to_json, status: :ok
    else
      return head :unauthorized
    end
  end

  private

  def set_card
    #@card = Card.where(id: params[:id]).first
    user = User.where(id: params[:user_id]).first
    @user_card = user.cards.where(id: params[:id]).first
  end

  def card_params
    params.permit( :id, :content, :color, :pick, :room_id, :user_id, :votes)
  end
end
