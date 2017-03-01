class AccessToken
  ALGORITHM = 'HS256'

  class << self
    def generate(payload)
      # exp = Time.now.to_i + 3600
      # JWT.encode(payload.merge(exp: exp), hmac_secret, ALGORITHM)
      JWT.encode(
        payload,
        auth_secret,
        ALGORITHM
      )
    end

    def decode(token)
      # JWT.decode(token, hmac_secret, true, leeway: 30, algorithm: ALGORITHM)[0]
      JWT.decode(
        token,
        auth_secret,
        true,
        algorithm: ALGORITHM
      ).first
    end

    private

    def hmac_secret
      Rails.application.secrets.secret_key_base
    end

    def auth_secret
      Rails.application.secrets.auth_secret
    end
  end
end
