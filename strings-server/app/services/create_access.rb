class CreateAccess
  def call
    access = FactoryGirl.create :access,
    user_id:  User.where.first[:id],
    key:      SecureRandom.uuid,
    secret:   SecureRandom.hex(30)
  end
  puts "Destroy Access: #{Access.count}"
end
