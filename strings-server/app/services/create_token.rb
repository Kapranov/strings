class CreateToken
  def call
    generate_token = SecureRandom.base64(25).tr('+/=', 'Qrt')
    exit if Token.any?

    token = FactoryGirl.create :token,
    apikey: generate_token,
    username: Rails.application.secrets.token_username.to_s,
    password: Rails.application.secrets.token_password.to_s,
    state: 'active'
  end
  puts "Destroy  Token: #{Token.count}"
end
