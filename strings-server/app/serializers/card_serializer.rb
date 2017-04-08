class CardSerializer < ActiveModel::Serializer
  attributes :id, :content, :color, :user_id, :room_id, :votes, :created_at, :updated_at
  belongs_to :user, url: ->(user){ "/users/#{user.id}/cards" }
  belongs_to :room, url: ->(room){ "/rooms/#{room.id}/cards" }
  link(:self) { user_url(object.user_id) }
  link(:self) { room_url(object.room_id) }

  def url
    card_url(object)
  end

  def created_at
    "#{object.created_at.to_s(:long)}"
  end

  def updated_at
    "#{object.updated_at.to_s(:long)}"
  end
end
