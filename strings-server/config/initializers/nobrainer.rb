NoBrainer.configure do |config|
  config.app_name = Rails.application.secrets.rethinkdb_db
  config.environment = config.default_environment
  config.rethinkdb_urls = [Rails.application.secrets.rethinkdb_url]
  config.ssl_options = nil
  config.driver = :regular
  config.logger = config.default_logger
  config.colorize_logger = true
  config.warn_on_active_record = false
  config.run_options = { :durability => config.default_durability }
  config.table_options = { :shards => 1, :replicas => 1, :write_acks => :majority }
  config.max_string_length = 255
  config.user_timezone = :local
  config.db_timezone = :utc
  config.distributed_lock_class = "NoBrainer::Lock"
  config.lock_options = { :expire => 60, :timeout => 10 }
  config.per_thread_connection = false
  config.criteria_cache_max_entries = 10_000
  config.machine_id = config.default_machine_id
end
