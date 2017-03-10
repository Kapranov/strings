require 'jwt'

class JsonWebToken
  ALGORITHM = 'HS256'

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, auth_secret, ALGORITHM)
  end

  def self.decode(token, leeway=0)
    body = JWT.decode(token, auth_secret, true, { leeway: leeway, algorithm: ALGORITHM })[0]
    HashWithIndifferentAccess.new body
  rescue
    nil
  end

  def self.auth_secret
    Rails.application.secrets.secret_key_base
  end
end
