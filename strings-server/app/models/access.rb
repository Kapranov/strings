class Access
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps

  belongs_to :user

  field :key,               type: String, uniq: true
  field :secret_digest,     type: String
  field :browser,           type: String
  field :operating_system,  type: String

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
    @secret ||= SecureRandom.base64(25).tr('+/=', 'Qrt')
  end
end
