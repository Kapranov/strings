class CreateCardsService
  def call
    User.each do |user|
      Room.each do |room|
        FactoryGirl.create :card,
        user_id: user.id.to_s,
        room_id: room.id.to_s,
        content: Faker::Zelda.game,
        color: Faker::Color.color_name,
        votes: rand(1..5)
      end
    end
  end
end
