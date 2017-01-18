NoBrainer.configure do |config|
  config.app_name = Rails.application.secrets.rethinkdb_db
  config.environment = config.default_environment
  config.rethinkdb_urls = [Rails.application.secrets.rethinkdb_url]
  config.logger = config.default_logger
  config.colorize_logger = true
  config.warn_on_active_record = false
  config.run_options = { :durability => config.default_durability }
end
