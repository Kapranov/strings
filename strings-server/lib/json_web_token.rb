require 'jwt'

class JsonWebToken
  class << self
    def encode(payload, exp = 24.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, Rails.application.secrets.secret_key_base)
    end
    def decode(token)
      body = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
      HashWithIndifferentAccess.new body
    rescue
      nil
    end
  end
end

# version #2
#class JsonWebToken
#  def self.encode(payload)
#    JWT.encode(payload, Rails.application.secrets.secret_key_base)
#  end
#
#  def self.decode(token)
#    return HashWithIndifferentAccess.new(JWT.decode(token, Rails.application.secrets.secret_key_base)[0])
#  rescue
#    nil
#  end
#end
