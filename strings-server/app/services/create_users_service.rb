class CreateUsersService
  def call
    10.times do
      @room = FactoryGirl.create :room,
      title: Faker::Team.name,
      black_card: Faker::Superhero.name,
      pick: rand(1..9)
    end

    puts "CREATED          Rooms: #{Room.count}"

    10.times do
      @user = User.create(
        last_name: Faker::Name.last_name,
        first_name: Faker::Name.first_name,
        middle_name: Faker::Name.first_name[0..2],
        email: Faker::Internet.safe_email,
        password: '87654321',
        password_confirmation: '87654321',
        description: Faker::Lorem.sentence
      )
      @user.save!
      %w(home work cell).each do |phone_name|
        phone = FactoryGirl.create :phone,
        user_id: @user.id,
        name: phone_name,
        phone_number: Faker::PhoneNumber.subscriber_number(12)
      end
    end

    puts "CREATED          Users: #{User.count}"
    puts "CREATED         Phones: #{Phone.count}"

    10.times do
      card = FactoryGirl.create :card,
      user_id: @user.id,
      room_id: @room.id,
      content: Faker::Zelda.game,
      color: Faker::Color.color_name,
      votes: rand(1..5)
    end

    puts "CREATED          Cards: #{Card.count}"
    puts "CREATED         Tokens: #{Token.count}"
  end
end
