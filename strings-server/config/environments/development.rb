Rails.application.configure do
  config.cache_classes = false
  config.eager_load = false
  config.consider_all_requests_local = true

  if ENV['REDIS_URL']
    config.action_controller.perform_caching = true
    config.cache_store = :redis_store, Rails.application.secrets.redis_url, { expires_in: 90.minutes }
  else
    config.action_controller.perform_caching = false
    config.cache_store = :null_store
  end

  config.action_dispatch.tld_length = 1
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.perform_caching = false
  config.active_support.deprecation = :log
end

# config.action_mailer.delivery_method = :smtp
# config.action_mailer.smtp_settings = { address: 'localhost', port: 1025 }
# config.action_mailer.default_url_options = { :host => 'localhost', port: '3000' }
#
# config.action_dispatch.tld_length = 1
#
# config.web_console.automount = true
# config.web_console.whitelisted_ips =  %w( 127.0.0.1 )
