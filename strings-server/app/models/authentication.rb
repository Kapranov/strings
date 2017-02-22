class Authentication
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps

  #validate :login

  belongs_to :user

  field :user_id,           type: String
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

  #def login
  #  return if model.user.present? && model.user.authenticate(password)
  #  errors.add(:base, :unauthenticated)
  #end

  #def model!(params)
  #  @user = User.where.first[:email]
  #  Authentication.new(
  #    user_id: @user,
  #    key: SecureRandom.uuid,
  #    secret: secret
  #  )
  #end

  private

  def secret
    @secret ||= SecureRandom.hex(30)
  end
end
