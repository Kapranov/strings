Rails.application.configure do
  config.eager_load = false
  config.cache_classes = false
  config.active_support.deprecation = :log
  config.consider_all_requests_local = true
  config.debug_exception_response_format = :api
  # debug|info|warn|error|fatal
  config.log_level = :info
end
