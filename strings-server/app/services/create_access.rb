class CreateAccess
  def call
    access = FactoryGirl.create :access,
    user_id:  User.where.first[:id],
    key:      SecureRandom.base64(25).tr('+/=', 'Qrt'),
    secret:   SecureRandom.base64(25).tr('+/=', 'Qrt')
  end
  puts "Destroy Access: #{Access.count}"
end
