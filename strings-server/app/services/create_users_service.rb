class CreateUsersService
  def call
    1.upto(2).each do
      user = FactoryGirl.create :user,
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        middle_name: Faker::Name.first_name[0..2],
        email: Faker::Internet.safe_email,
        password: '87654321',
        description: Faker::Lorem.sentence,
        state: 'locked'

        %w(home work cell).each do |phone_name|
          phone = FactoryGirl.create :phone,
          user_id: user.id.to_s,
          name: phone_name,
          phone_number: Faker::PhoneNumber.subscriber_number(12)
        end
    end
  end
end
