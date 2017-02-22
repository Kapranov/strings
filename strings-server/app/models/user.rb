class User
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps
  include ActiveModel::SecurePassword

  has_secure_password
  before_validation :access_token, on: [:create], unless: :apikey

  # EMAIL_REGEX = /A[w+-.]+@[a-zd-.]+.[a-z]+z/i
  # EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  EMAIL_REGEX = /^[\S&&[^@]]+@[\S&&[^@]]+$/

  self.include_root_in_json = true

  def self.roles
    [
      :'Admin',
      :'Manager',
      :'Contributor',
      :'Reviewer'
    ]
  end

  field :first_name,      type: String, required: true, min_length: 4
  field :last_name,       type: String, required: true, min_length: 4
  field :middle_name,     type: String, required: true, min_length: 2
  field :password_digest, type: String, required: true, min_length: 8
  field :apikey,          type: String, required: true, min_length: 25, uniq: true
  field :email,           type: String, required: true, min_length: 5,  uniq: true
  field :description,     type: Text,   required: true, min_length: 5
  field :role,            type: Enum,   required: true, in: self.roles, default: self.roles.first

  index :apikey

  validates :first_name,      presence: true, length: { minimum: 4,  allow_blank: false }
  validates :last_name,       presence: true, length: { minimum: 4,  allow_blank: false }
  validates :middle_name,     presence: true, length: { minimum: 2,  allow_blank: false }
  # validates :email,           presence: true, uniqueness: true, format: EMAIL_REGEX
  validates :email,           presence: true, length: { minimum: 5,  allow_blank: false }
  validates :description,     presence: true, length: { minimum: 5,  allow_blank: false }
  validates :apikey,          presence: true, length: { minimum: 25, allow_blank: false }
  # validates_length_of :password, in: 8..20, on: :create
  validates :password_digest, presence: { on: :create }, length: { minimum: 8, allow_blank: false }
  validates :role,            presence: true

  def access_token
    return if apikey.present?
    self.apikey = generate_authentication_token(token_generator)
    Rails.logger.info("Set new token for user #{ id }")
  end

  private

  def generate_authentication_token(token_generator)
    loop do
      set_apikey = token_generator
      break set_apikey if token_suitable?(set_apikey)
    end
  end

  def token_suitable?(set_apikey)
    # return if self.class.where(apikey: set_apikey).present?
    self.class.where(apikey: set_apikey).count == 0
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
