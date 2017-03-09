class AccessToken
  ALGORITHM = 'HS256'

  class << self
    def generate(payload)
      JWT.encode(
        payload,
        auth_secret,
        ALGORITHM
      )
    end

    def decode(token)
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
