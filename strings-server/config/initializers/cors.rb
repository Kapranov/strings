Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # origins '*'
    origins 'localhost:4200'

    resource '*',
      headers: :any,
      # methods: [:get, :post, :options]
      # :expose  => ['access-token', 'expiry', 'token-type', 'uid', 'client'],
      # :methods => [:get, :post, :options, :delete, :put]
      methods: %i(get post put patch delete options head)
  end
end
