class CardSerializer < ActiveModel::Serializer
  attributes :id, :content, :color, :user_id, :room_id, :votes
  belongs_to :user
  belongs_to :room
  link(:self) { card_url(object) }
end
