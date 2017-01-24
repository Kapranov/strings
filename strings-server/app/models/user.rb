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
  field :email,           type: String,             required: true
  field :description,     type: Text,               required: true, min_length: 5

  index :token

  has_secure_password

  validates :first_name,      presence: true
  validates :last_name,       presence: true
  validates :middle_name,     presence: true
  validates :password_digest, presence: true
  validates :token,           presence: true
  validates :email,           presence: true
  validates :description,     presence: true

  before_validation :access_token, on: [:create]

  def access_token
    if token.blank?
      self.token = generate_authentication_token(token_generator)
    end
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
    SecureRandom.hex(25)
  end

  def generate_token
    loop do
      set_token = SecureRandom.hex(25)
      break set_token unless User.where(token: set_token).first
    end
  end
end
