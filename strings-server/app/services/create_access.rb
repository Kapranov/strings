class CreateAccess
  def call
    access = FactoryGirl.create :access,
    user_id:  User.where.first[:id],
    key:      SecureRandom.base64(25).tr('+/=', 'Qrt'),
    secret:   SecureRandom.hex(30)
  end
  puts "Destroy Access: #{Access.count}"
end
