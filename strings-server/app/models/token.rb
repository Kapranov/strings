class Token
  include NoBrainer::Document
  include NoBrainer::Document::Timestamps

  before_validation :access_token, on: [:create], unless: :apikey

  self.include_root_in_json = true

  field :apikey, type: String, required: true, min_length: 25, uniq: true

  index :apikey

  validates :apikey, presence: true, length: { minimum: 25, allow_blank: false }

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
