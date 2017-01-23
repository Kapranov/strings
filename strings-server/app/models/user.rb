class User
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps
  include ActiveModel::SecurePassword

  field :first_name,      type: String,             required: true
  field :last_name,       type: String,             required: true
  field :middle_name,     type: String,             required: true
  field :password_digest, type: String,             required: true
  field :token,           type: String, uniq: true, required: true
  field :description,     type: Text,               required: true

  index :token

  has_secure_password

  validates :first_name,      presence: true
  validates :last_name,       presence: true
  validates :middle_name,     presence: true
  validates :password_digest, presence: true
  validates :token,           presence: true
  validates :description,     presence: true

  before_validation :access_token, on: [:create]

  private

  def access_token
    self.token = generate_token
  end

  def generate_token
    loop do
      set_token = SecureRandom.hex(25)
      break set_token unless User.where(token: set_token).present?
    end
  end
end
