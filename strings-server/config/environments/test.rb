Rails.application.configure do
  config.cache_classes = true
  config.consider_all_requests_local = true
  config.action_dispatch.show_exceptions = false
  config.action_controller.allow_forgery_protection = false
  config.active_support.deprecation = :log
  config.log_level = :debug
  config.eager_load = false
  config.allow_concurrency = false
end

Rails.application.routes.default_url_options = {
  host: Rails.application.secrets.domain_name,
  port: Rails.application.secrets.port
}
