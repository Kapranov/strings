Rails.application.configure do
  config.cache_classes = true
  config.eager_load = false
  if ENV['REDIS_URL']
    config.action_controller.perform_caching = true
    config.cache_store = :redis_store, Rails.application.secrets.redis_url, { expires_in: 90.minutes }
  else
    config.action_controller.perform_caching = false
    config.cache_store = :null_store
  end
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  config.action_dispatch.show_exceptions = false
  config.action_controller.allow_forgery_protection = false
  config.action_mailer.perform_caching = false
  config.action_mailer.delivery_method = :test
  config.active_support.deprecation = :stderr
end
