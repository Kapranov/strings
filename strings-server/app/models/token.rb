class Token
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps
  include ActiveModel::SecurePassword

  has_secure_password

  before_validation :access_token, on: [:create], unless: :apikey

  self.include_root_in_json = true

  field :apikey,          type: String, required: true, uniq: true, readonly: true
  field :username,        type: String, required: true, uniq: true
  field :password_digest, type: String, required: true
  field :state,           in: %w(active locked)

  index :apikey

  validates :apikey,          presence: true, length: { minimum: 25, allow_blank: false }
  validates :username,        presence: true, length: { in: 8..15,   allow_blank: false }
  validates :password_digest, presence: { on: :create }, length: { minimum: 8, allow_blank: false }

  def access_token
    return if apikey.present?
    self.apikey = generate_authentication_token(token_generator)
    Rails.logger.info("Set new token for user #{ id }")
  end

  private

  def generate_authentication_token(token_generator)
    loop do
      set_apikey = token_generator
      break unless Token.where(apikey: set_apikey).first.present?
    end
  end

  def token_suitable?(set_apikey)
    self.class.where(apikey: set_apikey).first.present?
  end

  def token_generator
    SecureRandom.base64(25).tr('+/=', 'Qrt')
  end

  def generate_token
    loop do
      set_apikey = SecureRandom.hex(25)
      break set_apikey unless User.where(apikey: set_apikey).first
    end
  end
end
