class Token
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps
  include ActiveModel::SecurePassword

  has_secure_password

  before_validation :set_auth_token, on: [:create], unless: :auth_token

  self.include_root_in_json = true

  field :username,        type: String, required: true, uniq: true
  field :password_digest, type: String, required: true
  field :auth_token,      type: String, required: true, uniq: true, readonly: true
  field :state,           in: %w(active locked)

  validates :username,        presence: true, length: { minimum: 4,  allow_blank: false }
  validates :password_digest, presence: { on: :create }, length: { minimum: 8, allow_blank: false }
  validates :auth_token,      presence: true, length: { minimum: 25, allow_blank: false }
  validates :state,           presence: true

  index :username
  index :auth_token

  private

  def set_auth_token
    return if auth_token.present?
    self.auth_token = generate_auth_token
    Rails.logger.info("Set new token for username #{ id } - #{username} - #{auth_token}")
  end

  def generate_auth_token
    SecureRandom.base64(25).tr('+/=', 'Qrt')
  end
end
