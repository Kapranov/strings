class CreateAdminService
  def call
    generate_token = SecureRandom.base64(25).tr('+/=', 'Qrt')

    user = FactoryGirl.create :user,
    first_name: Rails.application.secrets.admin_first_name.to_s,
    last_name: Rails.application.secrets.admin_last_name.to_s,
    middle_name: Rails.application.secrets.admin_middle_name.to_s,
    token: generate_token,
    password: Rails.application.secrets.admin_password.to_s,
    email: Rails.application.secrets.admin_email.to_s,
    description: Rails.application.secrets.admin_description.to_s
  end
  puts "Destroy all Users: #{User.count}"
end
