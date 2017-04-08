class RoomSerializer < ActiveModel::Serializer
  attributes :id, :title, :black_card, :pick, :created_at, :updated_at
  has_many :cards, data: true do
    link(:self) { room_cards_url(object) }
  end
  link(:self) { room_url(object.id) }

  def url
    room_url(object)
  end

  def created_at
    "#{object.created_at.to_s(:long)}"
  end

  def updated_at
    "#{object.updated_at.to_s(:long)}"
  end

  def current
    {
      content: "hello",
      color: "red",
      votes: 1,
      user_id: User.where.first[:id],
      room_id: Room.where.first[:id],
      status: "rainy"
    }
  end
end
