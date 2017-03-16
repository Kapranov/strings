class RoomSerializer < ActiveModel::Serializer
  attributes :id, :title, :black_card, :pick
  has_many :cards
  link(:self) { room_url(object) }

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
