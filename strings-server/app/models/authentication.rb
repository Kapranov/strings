class Authentication
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps

  before_validation :secret, on: [:create], unless: :secret_digest

  belongs_to :user

  field :user_id,           type: Integer
  field :key,               type: String, uniq: true
  field :secret_digest,     type: String
  field :browser,           type: String
  field :operating_system,  type: String

  index :user_id
  index :key

  attr_accessor :secret_unencrypted

  def secret=(unencrypted)
    self.secret_digest = BCrypt::Password.create(unencrypted)
    self.secret_unencrypted = unencrypted
  end

  def authenticate(unencrypted)
    BCrypt::Password.new(secret_digest) == unencrypted && self
  end

  private

  def secret
    @secret ||= SecureRandom.hex(30)
  end
end
