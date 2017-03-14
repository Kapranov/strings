Rails.application.configure do
  config.cache_classes = false
  config.consider_all_requests_local = false
  config.action_dispatch.show_exceptions = false
  config.action_controller.allow_forgery_protection = false
  config.active_support.deprecation = :log
  config.log_level = :debug
end

Rails.application.routes.default_url_options = {
  host: Rails.application.secrets.domain_name,
  post: Rails.application.secrets.port
}
