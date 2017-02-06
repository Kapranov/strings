Sidekiq.configure_server do |config|
  config.redis = { url: Rails.application.secrets.redis_url, :namespace => Rails.application.secrets.redis_namespace }
end

Sidekiq.configure_client do |config|
  config.redis = { url: Rails.application.secrets.redis_url, :namespace => Rails.application.secrets.redis_namespace }
end

