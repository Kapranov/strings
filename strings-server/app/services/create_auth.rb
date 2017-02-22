class CreateAuth
  def call
    authentication = FactoryGirl.create :authentication,
    user_id:  User.where.first[:id],
    key:      SecureRandom.uuid,
    secret:   SecureRandom.hex(30)
  end
  puts "Destroy   Auth: #{Authentication.count}"
end
