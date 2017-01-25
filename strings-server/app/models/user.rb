class User
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps
  include ActiveModel::SecurePassword
  # include ActiveModel::Serializers::Xml

  self.include_root_in_json = true

  field :first_name,      type: String,             required: true, min_length: 4
  field :last_name,       type: String,             required: true, min_length: 4
  field :middle_name,     type: String,             required: true, min_length: 2
  field :password_digest, type: String,             required: true, min_length: 8
  field :token,           type: String, uniq: true, required: true, min_length: 25
  field :email,           type: String,             required: true, min_length: 5
  field :description,     type: Text,               required: true, min_length: 5

  index :token

  has_secure_password

  validates :first_name,      presence: true, length: { minimum: 4, allow_blank: false }
  validates :last_name,       presence: true, length: { minimum: 4, allow_blank: false }
  validates :middle_name,     presence: true, length: { minimum: 2, allow_blank: false }
  validates :password_digest, presence: { on: :create }, length: { minimum: 8, allow_blank: false }
  validates :token,           presence: true, length: { minimum: 25, allow_blank: false }
  validates :email,           presence: true, length: { minimum: 5,  allow_blank: false }
  validates :description,     presence: true, length: { minimum: 5,  allow_blank: false }

  before_validation :access_token, on: [:create], unless: :token

  ROLES = {
    REGULAR: 1,
    ADMIN: 2,
    MANAGER: 3
  }

  def is_regular
    self.id_role == ROLES[:REGULAR]
  end

  def is_admin
    self.id_role == ROLES[:ADMIN]
  end

  def is_manager
    self.id_role == ROLES[:MANAGER]
  end

  def access_token
    return if token.present?
    self.token = generate_authentication_token(token_generator)
    Rails.logger.info("Set new token for user #{ id }")
  end

  private

  def generate_authentication_token(token_generator)
    loop do
      set_token = token_generator
      break set_token if token_suitable?(set_token)
    end
  end

  def token_suitable?(set_token)
    self.class.where(token: set_token).count == 0
  end

  def token_generator
    # SecureRandom.hex(25)
    SecureRandom.base64(25).tr('+/=', 'Qrt')
  end

  def generate_token
    loop do
      set_token = SecureRandom.hex(25)
      break set_token unless User.where(token: set_token).first
    end
  end
end
