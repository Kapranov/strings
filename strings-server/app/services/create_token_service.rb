class CreateTokenService
  def call
    token = FactoryGirl.create :token,
    username: Rails.application.secrets.token_username.to_s,
    password: Rails.application.secrets.token_password.to_s,
    state: 'active'
  end
end
