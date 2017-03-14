class CardsController < AuthenticationController
  before_action :set_authenticate
  before_action :set_card, only: [:show, :update, :destroy]

  def index
    @cards = Card.order_by(content: :desc)
    render json: Oj.dump(json_for(@cards, meta: meta), mode: :compat)
  end

  def show
    if @card
      render json: Oj.dump(json_for(@card, meta: meta), mode: :compat)
    else
      return head :unauthorized
    end
  end

  def create
    @card = Card.new(card_params)
    if @card.save
      render json: Oj.dump(json_for(@card, meta: meta), mode: :compat)
    else
      return head :unauthorized
    end
  end

  def destroy
    if @card.destroy
      render json: { message: "card deleted" }.to_json, status: :ok
    else
      return head :unauthorized
    end
  end

  def update
    if @card.update(card_params)
      render json: Oj.dump(json_for(@card, meta: meta), mode: :compat)
    else
      return head :unauthorized
    end
  end

  private

  def set_card
    @card = Card.where(id: params[:id]).first
  end

  def card_params
    params.permit(
      :id,
      :content,
      :color,
      :pick,
      :room_id,
      :user_id,
      :votes
      # phones_attributes: Phone.attribute_names.map(&:to_sym).push(:_destroy),
      #  cards_attributes:  Card.attribute_names.map(&:to_sym).push(:_destroy)
    )
  end
end
