class RoomSerializer < ActiveModel::Serializer
  attributes :id, :title, :black_card, :pick, :current
  has_many :cards

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
