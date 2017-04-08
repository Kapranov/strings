class CreateRoomsService
  def call
    1.upto(3).each do
      room = FactoryGirl.create :room,
        title: Faker::Team.name,
        black_card: Faker::Superhero.name,
        pick: rand(1..9)
    end
  end
end
