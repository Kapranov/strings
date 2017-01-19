Rails.application.configure do
  config.cache_classes = false
  config.eager_load = false
  config.consider_all_requests_local = true

  if ENV['REDIS_URL']
    config.action_controller.perform_caching = true
    # config.cache_store = :redis_store, Rails.application.secrets.redis_url, { expires_in: 90.minutes }
    config.cache_store = :redis_store, ENV['REDIS_URL']
  else
    config.action_controller.perform_caching = false
    config.cache_store = :null_store
  end

  config.action_dispatch.tld_length = 1
  config.active_support.deprecation = :log
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker

  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.perform_caching = false
  config.action_mailer.delivery_method = :letter_opener
  config.action_mailer.default_url_options = {
    host: Rails.application.secrets.domain_name,
    port: Rails.application.secrets.port
  }
  config.after_initialize do
    Rails.application.default_url_options[:host] = Rails.application.secrets.localhost
    Rails.application.routes.default_url_options[:host] = Rails.application.secrets.localhost
  end
end
