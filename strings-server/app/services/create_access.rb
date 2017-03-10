class CreateAccess
  def call
    access = FactoryGirl.create :access,
    user_id:  User.where.first[:id],
    key:      SecureRandom.base64(25).tr('+/=', 'Qrt'),
    secret:   Rails.application.secrets.admin_password.to_s
  end
  puts "Destroy Access: #{Access.count}"
end
