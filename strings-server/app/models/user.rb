class User
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps
  include ActiveModel::SecurePassword
  # include Authentication

  before_validation :set_auth_token, on: [:create], unless: :auth_token

  has_many :cards,  dependent: :destroy
  has_many :phones, dependent: :destroy

  has_secure_password

  self.include_root_in_json = true

  EMAIL_REGEX = /([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})/i

  def self.roles
    [
      :'Administrator',
      :'Manager',
      :'Contributor',
      :'Reviewer'
    ]
  end

  def self.set_default_role
    self.roles[3]
  end

  field :email,           type: String, required: true, uniq: true
  field :first_name,      type: String
  field :last_name,       type: String
  field :middle_name,     type: String
  field :password_digest, type: String, required: true
  field :auth_token,      type: String, required: true, uniq: true, readonly: true
  field :role,            type: Enum,   required: true, in: self.roles, default: self.set_default_role
  field :state,           in: %w(active locked), default: 'locked'
  field :admin,           type: Boolean, default: false
  field :description,     type: Text

  index :email
  index :auth_token

  validates :email,           presence: true, length: { minimum: 5,  allow_blank: false }, format: EMAIL_REGEX
  validates :first_name,      length: { minimum: 3,  allow_blank: true }
  validates :last_name,       presence: true, length: { minimum: 3,  allow_blank: false }
  validates :middle_name,     length: { minimum: 2,  allow_blank: true }
  validates :password_digest, presence: { on: :create }, length: { minimum: 8, allow_blank: false }
  validates :auth_token,      presence: true, length: { minimum: 25, allow_blank: false }
  validates :description,     length: { minimum: 5,  allow_blank: true }

  private

  def set_auth_token
    return if auth_token.present?
    self.auth_token = generate_auth_token
    Rails.logger.info("Set new token for username #{ id } - #{email} - #{auth_token}")
  end

  def generate_auth_token
    SecureRandom.base64(25).tr('+/=', 'Qrt')
  end
end
