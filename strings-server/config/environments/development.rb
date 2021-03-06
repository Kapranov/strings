Rails.application.configure do
  config.cache_classes = false
  config.eager_load = false
  config.log_level = :info
  config.consider_all_requests_local = false
  config.active_support.deprecation = :log
end

Rails.application.routes.default_url_options = {
  host: Rails.application.secrets.domain_name,
  port: Rails.application.secrets.port
}
